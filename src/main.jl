using Random, DataFrames, LinearAlgebra, Plots #import neccesary libraries



#Generate random dataset for readings
Random.seed!(1234) # an arbitrary random seed
n = 200 # number of data points
x = rand(n) .* 100 # random x values between 0 and 100

# Simulate a linear relationship with some noise
a = 1.45 #a = slope
b = .25 #b = intercept
deviation = 2.0 #standard deviation, will be used to generate random deviation
y = a .* x .+ b .+ deviation * randn(n) #applying the deviation to the normal output (using elementwise multiplication and addition)

df = DataFrame(col1=x, col2= y) # creates a dataframe object to pair the data of the original sensor reading (x) and the 'true' outputs (y)

#Functionality Check

#println(first(df, 5))
#println(last(df, 5))  
#description = describe(df)
#using Plots
#scatter(df.col1, df.col2,
#    xlabel="Sensor Reading",
#    ylabel="Measured Output",
#    title="Synthetic Sensor Dataset",
#    legend=false)
#savefig("C:\\Users\\Owner\\Documents\\CSI2560 Project\\figures\\scatter_plot.png")
