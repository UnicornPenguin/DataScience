using MLJ

LinearRegressor = @load LinearRegressor pkg=MLJLinearModels verbosity=0

function build_linear_regression()
    return LinearRegressor()
end