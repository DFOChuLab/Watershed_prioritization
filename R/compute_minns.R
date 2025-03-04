#' Compute I and Q indices in Minns (1987).
#'
#' @param pa `[matrix]`\cr a presence/absence matrix (site x species).
#' 
#' @references
#' * Minns, C. K. 'A Method of Ranking Species and Sites for Conservation Using
#' Presence-Absence Data and Its Application to Native Freshwater Fish in New
#' Zealand. New Zealand Journal of Zoology 14, no. 1 (January 1987): 43–49.
#' https://doi.org/10.1080/03014223.1987.10422680.
#'
#' @export

compute_minns_Q_I <- function(pa) {
    stopifnot(inherits(pa, "matrix"))
    # NB converting to 0/1 matrix
    pa <- (pa > 0) * 1
    # compute relative occurrence
    Pv <- apply(pa, 2, mean)
    # conservation priority
    Qv <- 1 - Pv
    # relative importance: see equation 2 of the original publication
    pq <- (pa %*% Qv)
    Ii <- pq / sum(Qv)
    # average priority
    richness <- apply(pa, 1, sum)
    Qi <- pq / richness
    # export results plus IQ (suggested in original publication)
    data.frame(Ii = Ii, Qi = Qi, IQ = (Ii + Qi) / 2)
}