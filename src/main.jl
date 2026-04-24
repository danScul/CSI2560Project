using Random, DataFrames, LinearAlgebra, Plots, CSV, Statistics #import neccesary libraries


df = CSV.read("data/Loadcell_Dataset.csv", DataFrame)

x = df[!, "Voltage (V)"]# sensor results

y = df[!, "Weight (gm)"] #true output

x_mean = mean(x) #mean of sensor results
y_mean = mean(y) #mean of true outputs

numer = sum((x .- x_mean) .* (y .- y_mean)) #numerator, calculates the error between sensor results and teh mean and the same for the outputs
denom = sum((x .- x_mean).^2) # denom, squared voltage variance
slope = numer/denom 
inter = y_mean - (slope * x_mean) #intercept
y_pred = slope .* x .+ inter # new prediction

println(first(df, 5))
println(last(df, 5))  
description = describe(df)
mkpath("figures")

p1 = scatter(x, y,
    xlabel="Voltage (V)",
    ylabel="Weight (gm)",
    title="Loadcell Dataset",
    legend=false)

x_sorted = sort(x)
y_sorted = inter .+ slope .* x_sorted

plot!(p1, x_sorted, y_sorted, color=:red)

savefig(p1, "figures/scatter_plot.png")

residuals = y .- y_pred

p2 = scatter(x, residuals,
    xlabel="Voltage (V)",
    ylabel="Residual",
    title="Residual Plot",
    legend=false)

hline!(p2, [0], linestyle=:dash)

savefig(p2, "figures/residual_plot.png")

p3 = histogram(residuals,
    bins=20,
    xlabel="Residual",
    ylabel="Frequency",
    title="Error Distribution",
    legend=false)

savefig(p3, "figures/error_histogram.png")

println("Intercept: ", min_slope[1])
println("Slope: ", min_slope[2])
