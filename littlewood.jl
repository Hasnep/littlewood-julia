# Load packages

using Polynomials: roots, Polynomial # For finding roots
using StatsBase: fit, Histogram # For binning the roots
using ColorSchemes: viridis
using Images: save # For saving the histogram to an image

# Create every combination of -1 and 1

polynomials = Iterators.product(repeat([[1, -1]], 2)...) |> collect |> vec .|> Polynomial;

# Solve the polynomials

complex_roots =
    polynomials .|>
    roots |>
    Iterators.flatten |>
    collect |>
    (Z -> filter(z -> imag(z) != 0, Z));

# Bin the roots

heatmap = fit(Histogram, (imag.(complex_roots), real.(complex_roots)), nbins = 2000).weights;

# Normalise

heatmap_normalised = log.(1 .+ heatmap);

# Apply a colour scheme

heatmap_coloured = get(viridis, heatmap_normalised, :extrema);

# Save the histogram to a file

save(joinpath("images", "littlewood.png"), heatmap_coloured);

# ![The Littlewood fractal](images/littlewood.png)
