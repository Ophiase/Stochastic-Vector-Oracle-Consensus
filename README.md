# Stochastic Vector Oracle Consensus

[StarkHack Hackaton](https://ethglobal.com/events/starkhack) participation.

Establish a consensus over oracles' predictions that can evolve through time.

## Global Modeling

### Statistical Model

Let $M$ be the number of attributes.
Let $N$ be the number of oracles.

Let $\Omega = C = [0, 1]^M \subset \mathbb{R}^M$ be the state space.
Let's assume $e \in \Omega$ is the true essence of the phenomenon.
Let $\mu : \Omega \to [0, 1]$ be the probability law of an oracle.

An oracle's prediction is a realization of the law $\mu$ over $C$.

In this project, we consider $N$ oracles' predictions of the same phenomenon: $(C^N, \mathcal{B}(C)^{\otimes N}, \mu^{\otimes N})$

We want to approximate the value of $c$ and estimate the credibility of this estimation.

### Example

Let's say we want to create smart contracts based on the psychology of investors in Bitcoin.
We can base our analysis on the following criteria:
- We model the psychology of an individual as a vector of bases:
(stress, anger, euphoria) with values between $0$ and $1$.
- We consider the following two groups: (crowd, famous investors)

An oracle will predict a vector with the following labeled coordinates:
(crowd stress, crowd anger, crowd euphoria, famous investors stress, famous investors anger, famous investors euphoria)

We consider 3 societies (A, B, C) and 10 oracles with 5 from A, 3 from B, and 2 from C.

It is assumed that oracles from different societies can use different algorithms.

## Gaussian Modeling

A first assumption we can make to simplify the problem is to consider that not matter the society and the algorithm, \
the prediction $X$ is a gaussian law centered in $e$ : \
- $X \sim \mathcal N(e, \sigma Id_M)^N \sim \mathcal N(E, \sigma Id_{MN})$

## Binary Gaussian Modeling

In a second time we might even consider a case with $K$ instances of $e$ with $\mu_k \sim \mathcal{N}(e_k, \sigma_k)$. \
Each oracle will have a probability of $p_k$ to follow $\mu_k$. Mathematicaly :
- $w \sim Mult(1, p)$ ie. $w$ is a discrete random variable of law $p$
- $x \sim \sum^K_k \mathcal{N}(e_k, \sigma_k) \times \mathbb{1}_w$

## Failing Oracle

Now, we will consider that when an oracle makes a prediction, it has a probability of $\alpha$ to fail.

- Security issues: An oracle can get hacked
- Bug

Consequence : we want to be able to replace only the worst oracle relatively to the consensus.

## Algorithms

In the following, we'll consider a smart contract that establish a consensus on $e$ value.
Each oracle we'll be represented by an address.
The contract will keep in memory an accuracy score for each address.

