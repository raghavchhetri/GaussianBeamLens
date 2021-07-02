using GLMakie
#lines
x = LinRange(0, 10, 100)
y1 = sin.(x)
y2 = cos.(x)

fig = Figure()
lines(fig[1, 1], x, y1, color = :red)
lines(fig[1, 2], x, y2, color = :blue)

lines(fig[2, 1:2], x, y1, color = :red, label = "sin")
lines!(fig[2, 1:2], x, y2, color = :blue, label = "cos")
axislegend()
#current_figure()
fig