import Pkg

Pkg.add("Plots")
Pkg.add("HTTP")
Pkg.add("JSON")

using Plots
using Dates
using HTTP
using JSON

#= busca dos dados na API =#
url = "https://api.bcb.gov.br/dados/serie/bcdata.sgs.10844/dados?formato=json&dataInicial=01/01/2023&dataFinal=01/09/2023"


res = HTTP.get(url)

data = JSON.parse(String(res.body))


#= Gráficos =#


config = Dict(
    "dir" => "ipca",
    "file_type" => "png" #= pode ser svg tbm =#
)

obj = Dict(
    "t1" => "IPCA",
    "t2" => "Mês"
)

year = "2023"
points = [parse(Float16, i["valor"]) for i in data ]
months = [split(i["data"], "/")[2] for i in data ]

print(months)
print(points)

cl = :steelblue
plt = plot(bar(months, points, color = color = cl, linecolor = cl,), title = "$(obj["t1"]) por $(obj["t2"])", xlabel = "Mês", ylabel = "IPCA (%)", label = false)

savefig("$(config["dir"])/ipca-mes$(Dates.format(now(), "HH_MM_SS")).$(config["file_type"])")

display(plt)
