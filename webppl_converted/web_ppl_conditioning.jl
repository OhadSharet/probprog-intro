using Turing, StatsPlots, Random

@model function model_cond_sum_abc(data)

    a ~ Beta(1, 1) #prior probability , we are giving a gess of what a looks like
                    #in this case a range

    for n in 1:100
        if sum(data[n]) == 2
            data[n][1]~Bernoulli(a)  #why do we use Bernoulli?
        end
    end

end

iterations = 10000
ϵ = 0.05
τ = 10

data = []
for n in 1:100
    push!(data,rand(Bernoulli(0.5), 3))
end



chain = sample(model_cond_sum_abc(data), HMC(ϵ, τ), iterations)
histogram(chain)
