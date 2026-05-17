using CSV
using DataFrames
using Dates
using MLJ

include("features.jl")
include("metrics.jl")

function load_region_dataset(config)
    
    weather = CSV.read(config.weather_path, DataFrame)
    energy = CSV.read(config.energy_path, DataFrame)

    weather.date = Date.(weather.date)
    energy.date = Date.(energy.date)

    df = innerjoin(
        weather,
        select(energy, :date, config.target),
        on = :date
    )

    sort!(df, :date)

end