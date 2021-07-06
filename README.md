# Transmission of a Gaussian Beam through a Lens
7-01-2021
### About:
Exploration of Julia 1.6.1 for simple optical simulations
- Using FFTW v1.4.3 and GLMakie v0.4.2
- Platform: Windows 10 Pro [my machine: D13]

### VS Code:
- Navigate to the folder to use ("GaussianBeamLens"), Right-click > Open with VS Code
- Start a Julia REPL with <code> ALT + J + O </code> or <code> Option + J + O </code> in Mac
- Create a Julia environment for the scripts in this folder as follows:\
  Go to the package manager from Julia REPL with <code>]</code>, then \
    <code>(@v1.6) pkg> activate .</code> \
    <code>(@v1.6) pkg> add GLMakie, FFTW </code>\
    <code>(@v1.6) pkg> status </code>-- this should show only two packages, <code>GLMakie </code> and <code>FFTW</code>\
  Note that <code>Manifest.toml</code> and <code>Project.toml</code> are generated in this folder after the above steps

### Verdict:
  - The interactive plot generated with GLMakie is nice. However, I've found that it takes a long time not only to initialize GLMakie, but once 
  it's precompiled, the code itself takes a considerable amount of time to run (2 minutes+ on my machine). Even the simple <code>Test_GLMakie_Plots.jl</code> takes several seconds.
  <code>GaussianBeamLens</code>  4.927917 seconds (7.82 M allocations: 622.319 MiB, 4.16% gc time, 2.16% compilation time)
  <code>heatmap</code>  59.041769 seconds (92.66 M allocations: 5.471 GiB, 3.91% gc time, 65.50% compilation time)
  <code>labelslidergrid!</code>  9.985507 seconds (17.61 M allocations: 1.021 GiB, 4.46% gc time, 99.67% compilation time)
  The irony is that this code only needs to run once. So, the benefit of speed for runs 2 and later (numbers below) is irrelevent for situations like this.
  <code>GaussianBeamLens</code>  0.463848 seconds (258.34 k allocations: 157.616 MiB, 7.76% gc time, 28.38% compilation time)
  <code>heatmap</code>  0.125093 seconds (158.68 k allocations: 11.320 MiB, 26.83% gc time)
  <code>labelslidergrid!</code>  0.237762 seconds (448.46 k allocations: 26.290 MiB, 94.47% compilation time)
  - Hopefully, GLMakie and the visualization landscape will improve over time, but at present, I don't see a reason to switch to Julia from MATLAB/Python/Mathematica for these types of tasks. 
#### rc
