using CSV
using DataFrames
using Dates
using ScientificTypes
using Statistics
using CairoMakie

df = CSV.read("../data/partial/weather/austin.csv", DataFrame)

df.date = Date.(df.date)

fig = Figure(size = (700, 700))

ax = Axis(
    fig[1,1], 
    title = "Rozkład temperatury maksymalnej i minimalnej w czasie",
    xlabel = "Data",
    ylabel = "Temperatura",
)

lines!(ax, df.date, df.max_temp, label = "MAX")
lines!(ax, df.date, df.min_temp, label = "MIN")
axislegend(ax)
save("Wykres temperatury.svg", fig) 

fig