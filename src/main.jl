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
scatter(df[!, "Voltage (V)"], df[!, "Weight (gm)"],
    xlabel="Votlage (V)",
    ylabel="Weight (gm)",
    title="Loadcell Dataset",
    legend=false)
    x_sorted = sort(df[!, "Voltage (V)"])
    y_sorted = min_slope[1] .+ min_slope[2] .* x_sorted
    plot!(x_sorted, y_sorted, color=:red, label="Fitted Line")
savefig("C:\\Users\\Owner\\Documents\\CSI2560 Project\\figures\\scatter_plot.png")

println("Intercept: ", min_slope[1])
println("Slope: ", min_slope[2])
