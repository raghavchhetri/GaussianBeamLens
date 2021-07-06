using FFTW: ifft, fft, ifftshift, fftshift
using GLMakie: Node, @lift, labelslidergrid!, set_close_to!, connect!
using GLMakie: Figure, heatmap, contourf

# Define grid and space
L = 1                      # wavelength of light 
n = 1                      # refractive index
k = 2*pi*n/L               # wave number in material
Nx = 1024                  # number of x cells
dx = L/2                   # length of x cells
Lx = Nx*dx                 # length of grid in x
dkx = (2*pi)/Lx            # length of kx cell
Nkx = Nx                   # same number of cells in real and fourier space

x = dx.*(-(Nx/2):Nx/2-1)
kx = dkx.*(-(Nkx/2):Nkx/2-1)
kz = sqrt.(k^2 .- kx.^2)

dz = 10                    # steps in z
zmax = 6000                # end of grid in z
z = 0:dz:zmax              # z grid

"""
    GaussianBeamLens(x0,w0,f,Lens_z)
        x0:     Lateral offset of the input beam
        w0:     Width of the Gaussian beam in object space
        f:      Focal length of the lens
        Lens_z: Axial Position of the lens
Computes the intensity of the optical field at every point in x (lateral) and z (axial)
"""
function GaussianBeamLens(x0,w0,f,Lens_z)
    E = exp.(-((x .- x0)./w0).^2)             # initial transverse electric field
    Tf = exp.(1im.*k.*(x.^2)/(2*f))           # transmission function for a thin lens
    
    # Propagate beam
    FE = zeros(Complex{Float64},length(z),length(E))
    FE[1,:] = E

    for d = 1:length(z)-1
        FE[d+1,:] = ifft(ifftshift( fftshift(fft(FE[d,:])).*exp.(-1im.*kz.*dz) ))
        if abs(z[d]- Lens_z) < dz/2        
            FE[d+1,:] = FE[d+1,:].*Tf
        end
    end
    I = abs.(FE).^2                # intensity of the field at every point in x and z
    return I
end

# Sliders
x0_index = Node(1)
w0_index = Node(2)
f_index = Node(3)
Lensz_index = Node(4)

# Use the values from the Sliders as inputs to get Intensity of the field at every point in x and z
@time I = @lift(GaussianBeamLens($x0_index, $w0_index, $f_index, $Lensz_index))

# Initialize figure
fig = Figure(resolution = (2304, 768))

@time heatmap(fig[1, 1], z, x, I, 
	colormap = :thermal,
	axis =(aspect=3,
		title = "Gaussian Beam: Lens Transmission",
        xlabel="Propagation Direction (z)", 
        ylabel="Lateral Offset (x)"))
#Other colormap options: deep

# Define a grid with slider label, value ranges
@time lsgrid = labelslidergrid!(
    fig,
    ["lateral offset", "input beam width", "focal length", "lens z-position"],
    [-240:10:240, 2:1:50, 0:10:2000, 0:10:2000];
    formats = [x -> "$x λ"],
    width = 555,
    tellheight = false)
fig[1, 2] = lsgrid.layout

# Set default value for each slider
set_close_to!(lsgrid.sliders[1], 60)
set_close_to!(lsgrid.sliders[2], 32)
set_close_to!(lsgrid.sliders[3], 1000)
set_close_to!(lsgrid.sliders[4],1000)

# Connect sliders to values
connect!(x0_index, lsgrid.sliders[1].value)
connect!(w0_index, lsgrid.sliders[2].value)
connect!(f_index, lsgrid.sliders[3].value)
connect!(Lensz_index, lsgrid.sliders[4].value)

# show figure
fig