

using Distributions, Plots
function tring_hstograma(args)

    dist = Normal(0, 1)
    data = rand(dist, 1000)
    histogram(data, normalize=false,nbins = 5)
    plot!(x->pdf(dist, x), xlim=xlims())
end

function _flip_3_coins()
    coin = Bernoulli(0.5)
    sum = rand(coin)+rand(coin)+rand(coin)

end
function coin_flip_PPL()
    data  = [_flip_3_coins() for _ in 1:100]
    histogram(data)
end

function hospital()
    lungCancer = rand(Bernoulli(0.01))
    TB = rand(Bernoulli(0.005))
    stomachFlu = rand(Bernoulli(0.1))
    cold = rand(Bernoulli(0.2))
    other = rand(Bernoulli(0.1))

 cough =
    (cold && rand(Bernoulli(0.5))) ||
    (lungCancer && rand(Bernoulli(0.3))) ||
    (TB && rand(Bernoulli(0.7))) ||
    (other && rand(Bernoulli(0.01)))

    fever =
    (cold && rand(Bernoulli(0.3))) ||
    (stomachFlu && rand(Bernoulli(0.5))) ||
    (TB && rand(Bernoulli(0.1))) ||
    (other && rand(Bernoulli(0.01)))

 chestPain =
    (lungCancer && rand(Bernoulli(0.5))) ||
    (TB && rand(Bernoulli(0.5))) ||
    (other && rand(Bernoulli(0.01)))

 shortnessOfBreath =
    (lungCancer && rand(Bernoulli(0.5))) ||
    (TB && rand(Bernoulli(0.2))) ||
    (other && rand(Bernoulli(0.01)))

    symptoms = Dict(
      "cough"=> cough,
      "fever"=> fever,
      "chestPain"=> chestPain,
      "shortnessOfBreath" => shortnessOfBreath
    )
    symptoms


end

_flip_3_coins()

coin_flip_PPL()

hospital()
