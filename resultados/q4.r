# Gerar a análise de tamanho de efeito:
# comparativo de qualidade para cada instância e pares de abordagens NSGAII x MAR , NSGAII x SH e NSGAII x CPM (página 1065).

rm(list=ls())
setwd("/Users/andrefarzat/Documents/mc2/dados")
DIGIT <- 4

# http://doofussoftware.blogspot.com.br/2012/07/measuring-effect-size-with-vargha.html
AMeasure <- function(a, b){
  
  # Compute the rank sum (Eqn 13)
  r <- rank(c(a, b))
  r1 <- sum(r[seq_along(a)])
  
  # Compute the measure (Eqn 14) 
  m <- length(a)
  n <- length(b)
  A <- (r1 / m - (m + 1) / 2) / n
  A
}

data <- read.table("data_t3-t4.txt", header = TRUE)
instances <- unique(data$inst)
instance_names <- list(c("MAR", "SH", "CPM"), instances)
best_result <- matrix(ncol = length(instances), nrow = 3, dimnames = instance_names)
gd_result <- matrix(ncol = length(instances), nrow = 3, dimnames = instance_names)
hv_result <- matrix(ncol = length(instances), nrow = 3, dimnames = instance_names)
i <- 1

for (instance in instances) {
  mar_data = data[ which(data$config == 'MAR' & data$inst == instance), ]
  sh_data = data[ which(data$config == 'SH' & data$inst == instance), ]
  cpm_data = data[ which(data$config == 'CPM' & data$inst == instance), ]
  nsga_data = data[ which(data$config == 'nsga150k2x' & data$inst == instance), ]

  best_result[1, i] <- AMeasure(nsga_data$best, mar_data$best)
  best_result[2, i] <- AMeasure(nsga_data$best, sh_data$best)
  best_result[3, i] <- AMeasure(nsga_data$best, cpm_data$best)
  
  hv_result[1, i] <- AMeasure(nsga_data$hv, mar_data$hv)
  hv_result[2, i] <- AMeasure(nsga_data$hv, sh_data$hv)
  hv_result[3, i] <- AMeasure(nsga_data$hv, cpm_data$hv)
  
  gd_result[1, i] <- AMeasure(nsga_data$gd, mar_data$gd)
  gd_result[2, i] <- AMeasure(nsga_data$gd, sh_data$gd)
  gd_result[3, i] <- AMeasure(nsga_data$gd, cpm_data$gd)

  i <- i + 1
}

print("Best ===============")
print(best_result)

print("HV ===============")
print(hv_result)

print("GD ===============")
print(gd_result)





#print(AMeasure(result$nsga150k2x, result$CPM))
#print(AMeasure(result$nsga150k2x, result$MAR))
#print(AMeasure(result$nsga150k2x, result$SH))
