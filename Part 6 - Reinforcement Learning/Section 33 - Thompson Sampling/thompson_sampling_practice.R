# Reinforcement learning - Thompson Algorithm

# Importing the dataset
dataset = read.csv('Ads_CTR_Optimisation.csv')

# Implementing Thompson Algorithm
# Thompson Sampling - Step 1
N = 10000
d = 10
ads_selected = integer()
numbers_of_rewards_1 = integer(d)
numbers_of_rewards_0 = integer(d)
total_reward = 0

# Thompson Sampling - Step 2
for (n in 1:N) {
  max_random = 0
  ad = 0
  for(i in 1:d) {
    random_beta = rbeta(n = 1,
                        shape1 = numbers_of_rewards_1[i] + 1,
                        shape2 = numbers_of_rewards_0[i] + 1)
   
# Thompson Sampling - Step 3
    if (random_beta > max_random) {
      max_random = random_beta
      ad = i
    }
  }
  ads_selected = append(ads_selected, ad)
  reward = dataset[n, ad]
  if (reward == 1) {
    numbers_of_rewards_1[ad] = numbers_of_rewards_1[ad] + 1
  } else {
    numbers_of_rewards_0[ad] = numbers_of_rewards_0[ad] + 1
  }
  total_reward = total_reward + reward
}

# Visualising the results
hist(ads_selected,
     col = 'blue',
     main = 'Histogram of ads selections',
     xlab = 'Ads',
     ylab = 'Number of times each ad was selected')