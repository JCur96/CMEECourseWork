# preallocate.R


a <- NA
Npreallo <- function(a) {
  a <- c(a, i)
  for (i in 1:100000) { 
    a[i] = 10
  }
}
print(system.time(Npreallo))






preallo <- function(b) {
  b <- rep(NA, 100000)
  for (i in 1:100000) {
  b[i] = 100000
  }
}
print(system.time(preallo))