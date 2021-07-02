### A Pluto.jl notebook ###
# v0.14.8

using Markdown
using InteractiveUtils

# ╔═╡ c6dcbe96-28ea-4b53-869c-aaacea58925e
begin
	using FFTW: ifft, fft, ifftshift, fftshift
	using GLMakie: heatmap, contourf
	# Define grid and space
	L = 1;                      # wavelength of light 
	n = 1.0;                    # index of air
	k = 2*pi*n/L;               # wave number in material
	Nx = 1024;                  # number of x cells
	dx = L/2;                   # length of x cells
	Lx = Nx*dx;                 # length of grid in x
	dkx = (2*pi)/Lx;            # length of kx cell
	Nkx = Nx;                   # same number of cells in real and fourier space 
	
	x = dx.*(-(Nx/2):Nx/2-1);
	kx = dkx.*(-(Nkx/2):Nkx/2-1);
	kz = sqrt.(k^2 .- kx.^2);
	
	dz = 10;                    # steps in z
	zmax = 6000;                # end of grid in z
	z = 0:dz:zmax;              # z grid
	
	# Define object-space Gaussian beam position (up/down) and waist
	x0 = 0.0;
	w0 = 5.0;
	f = 1000;								   # focal length of lens
	Lens_z = 2000;							   # Position of lens
	E = exp.(-((x .- x0)./w0).^2);             # initial transverse electric field
	Tf = exp.(1im.*k.*(x.^2)/(2*f));           # transmission function for a thin lens
	
	# Propagate beam
	FE = zeros(Complex{Float64},length(z),length(E));
	FE[1,:] = E;
	
	for d = 1:length(z)-1;
		FE[d+1,:] = ifft(ifftshift( fftshift(fft(FE[d,:])).*exp.(-1im.*kz.*dz) ));
		if abs(z[d]- Lens_z) < dz/2;        
			FE[d+1,:] = FE[d+1,:].*Tf;
		end
	end
	I = abs.(FE).^2;                    # intensity of field at every point in x and z
end

# ╔═╡ 0dba9c8b-7ee1-4e6f-866f-8922fafe01df
heatmap(z, x, I, 
	colormap = :thermal,
	axis =(
		aspect=3,
		title = "Gaussian Beam thru' a lens (all units wrt wavelength)",
        xlabel="propagation direction (z)", 
        ylabel="lateral (x)"))
#Other colormap options: deep

# ╔═╡ cbbb3ebc-673d-4eaf-9b2a-3cc53bc7a8e8
contourf(z, x, I, 
	colormap = :deep,
	axis =(
		aspect=3,
		title = "Gaussian Beam thru' a lens (all units wrt wavelength)",
        xlabel="propagation direction (z)", 
        ylabel="lateral (x)"))

# ╔═╡ Cell order:
# ╠═c6dcbe96-28ea-4b53-869c-aaacea58925e
# ╠═0dba9c8b-7ee1-4e6f-866f-8922fafe01df
# ╠═cbbb3ebc-673d-4eaf-9b2a-3cc53bc7a8e8
