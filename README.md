# Transmission of a Gaussian Beam through a Lens
7-01-2021
### About:
Exploration of Julia 1.6.1 for simple optical simulations
- Using FFTW v1.4.3 and GLMakie v0.4.2
- Platform: Windows 10 Pro

### VS Code:
- Navigate to the <code>"GaussianBeamLens"</code> folder, Right-click > Open with VS Code
- Start a Julia REPL with <code> ALT + J + O </code> or <code> Option + J + O </code> in Mac
- Create a Julia environment for the scripts in this folder as follows:\
  Go to the package manager from Julia REPL with <code>]</code>, then \
    <code>(@v1.6) pkg> activate .</code> \
    <code>(@v1.6) pkg> add GLMakie, FFTW </code>\
    <code>(@v1.6) pkg> status </code>-- this should show only two packages, <code>GLMakie </code> and <code>FFTW</code>\
  Note that <code>Manifest.toml</code> and <code>Project.toml</code> are generated in this folder after the above steps

### Verdict:
![Gaussian Beam Lens](demo/GaussianBeamLens.gif)

  - The interactive plot generated with <code>GLMakie</code> is nice. However, I've found that it takes a long time not only to initialize <code>GLMakie</code>, but once it's precompiled, the code itself takes a considerable amount of time to generate the output (2 minutes+ on my machine). Even the simple <code>Test_GLMakie_Plots.jl</code> took 2+ minutes.\
  <code> GaussianBeamLens + GLMakie heatmap + GLMakie labelslidergrid! </code>\
  <code> 3.239748 seconds (4.75 M allocations: 441.220 MiB, 4.99% gc time, 17.12% compilation time) </code>\
  <code> 59.421104 seconds (92.34 M allocations: 5.453 GiB, 4.02% gc time, 65.05% compilation time) </code>\
  <code> 9.986559 seconds (17.61 M allocations: 1.021 GiB, 4.72% gc time, 99.67% compilation time) </code>

  - Since this code only needs to run once, the performance benefit of re-running it (numbers below) is practically irrelevant.\
  <code> 0.463848 seconds (258.34 k allocations: 157.616 MiB, 7.76% gc time, 28.38% compilation time)</code>\
  <code> 0.125093 seconds (158.68 k allocations: 11.320 MiB, 26.83% gc time)</code>\
  <code> 0.237762 seconds (448.46 k allocations: 26.290 MiB, 94.47% compilation time)</code></code>\

  - The issue at heart is that Julia doesn't save compiled code, so when a new session is started, everything needs to be compiled again. A workaround is to use [<code>PackageCompiler</code>](https://julialang.github.io/PackageCompiler.jl/dev/) to create a custom Julia sysimage which saves the compiled state, thereby reducing the startup time. However, you'll be missing out on new udpates to the packages, which for active packages, such as <code>GLMakie</code>, happen frequently at the moment. Others have voiced a similar sentiment about this ["time-to-first-plot" issue](https://discourse.julialang.org/t/starting-glmakie-takes-very-long/64106).

  - Overall, the visualization with <code>GLMakie</code> once you get it is pretty awesome, but the wait time sucks. Hopefully, <code>GLMakie</code>, the visualization landscape, and the startup latency issue in Julia will improve in the future, thereby making a switch to Julia from MATLAB/Python/Mathematica for these types of tasks more compelling.  


#### rc
