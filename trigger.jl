import Pkg

Pkg.add("Plots")

using Plots
using Dates

config = Dict(
    "dir" => "juros",
    "file_type" => "png" #= pode ser svg tbm =#
)

obj = Dict(
    "t1" => "Juros Simples",
    "t2" => "Juros Compostos"
)



C = 500
i = 0.1
#= t varia com o x =#

x = range(0, 30, length=100)

Msimples(t) = C * (1 + i * t)
y = @. Msimples(x)

plt = plot(x, y, title = "$(obj["t1"]) vs $(obj["t2"])", xlabel = "Tempo", ylabel = "Montante", label = "$(obj["t1"])")

Mcomposto(t) = C * (1+ i) ^ t 
y = @. Mcomposto(x)

plot!(x, y, label = "$(obj["t2"])")

savefig("$(config["dir"])/montante-tempo$(Dates.format(now(), "HH_MM_SS")).$(config["file_type"])")

#= Figura 2 =#

i = 0.15
x = range(0, 1.5, length=100)
y = @. Msimples(x)

plot(x, y, title = "$(obj["t1"]) vs $(obj["t2"])", xlabel = "Tempo", ylabel = "Montante", label = "$(obj["t1"])")
y = @. Mcomposto(x)
plot!(x, y, label = "$(obj["t2"])")

savefig("$(config["dir"])/montante-tempo_zoom$(Dates.format(now(), "HH_MM_SS")).$(config["file_type"])")