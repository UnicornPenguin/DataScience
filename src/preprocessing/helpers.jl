function loader(path::AbstractString)
    df = CSV.read(path, DataFrame)

    return df
end

function parse_numbers(num)

    x = strip(String(num))
    x = replace(x, " " => "")    
    x = replace(x, "," => ".")    

    return parse(Float64, x)
end


#!TODO - dla każdego podregionu osobno i dla ercot zagregowane 
# mean
# sum
# max
# min
# std
# range
# load_factor
# peak_ratio

function agregate_distribute(df::DataFrame; by_col=:date)
        agregated_df = combine(
            groupby(df, by_col),
            #SECTION - coast
            :coast => mean    => :coast_mean,
            :coast => sum     => :coast_daily,
            :coast => maximum => :coast_max,
            :coast => minimum => :coast_min,
            :coast => std     => :coast_std,
            :coast => ((x) -> maximum(x) - minimum(x)) => :coast_range,
            :coast => ((x) -> mean(x) / maximum(x)) => :coast_load_factor,
            :coast => ((x) -> maximum(x) / mean(x)) => :coast_peak_ratio,




            #SECTION - north
            :north => mean => :north_daily,
            #SECTION - scent
            :scent => mean => :scent_daily,
            #SECTION - ercot
            :ercot => mean => :ercot_daily
            )

    return agregated_df
end
