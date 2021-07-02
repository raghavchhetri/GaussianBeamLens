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
  The irony is that this code only needs to run once. So, the benefit of speed for runs 2 and later, which Julia offers, is irrelevent for situations like this.
  - Hopefully, GLMakie and the visualization landscape will improve over time, but at present, I don't see a reason to switch to Julia from MATLAB/Python/Mathematica for these types of tasks.
  #### rc
