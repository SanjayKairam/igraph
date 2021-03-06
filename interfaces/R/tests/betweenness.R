
library(igraph)

## Plain

kite <- graph.formula(Andre    - Beverly:Carol:Diane:Fernando,
                      Beverly  - Andre:Diane:Ed:Garth,
                      Carol    - Andre:Diane:Fernando,
                      Diane    - Andre:Beverly:Carol:Ed:Fernando:Garth,
                      Ed       - Beverly:Diane:Garth,
                      Fernando - Andre:Carol:Diane:Garth:Heather,
                      Garth    - Beverly:Diane:Ed:Fernando:Heather,
                      Heather  - Fernando:Garth:Ike,
                      Ike      - Heather:Jane,
                      Jane     - Ike)
kite <- simplify(kite)
nf <- (vcount(kite)-1) * (vcount(kite)-2) /2
bet <- structure(betweenness(kite) / nf, names=V(kite)$name)
round(sort(bet, decreasing=TRUE), 3)

bet2 <- structure(betweenness(kite, normalized=TRUE), names=V(kite)$name)
round(sort(bet2, decreasing=TRUE), 3)

## Weighted

nontriv <- graph( c(0,19,0,16,0,20,1,19,2,5,3,7,3,8,
                    4,15,4,11,5,8,5,19,6,7,6,10,6,8,
                    6,9,7,20,9,10,9,20,10,19,
                    11,12,11,20,12,15,13,15,
                    14,18,14,16,14,17,15,16,17,18)+1, dir=FALSE )
  
E(nontriv)$weight <- c(0.5249, 1, 0.1934, 0.6274, 0.5249, 
                       0.0029, 0.3831, 0.05, 0.6274, 0.3831, 
                       0.5249, 0.0587, 0.0579, 0.0562, 0.0562, 
                       0.1934, 0.6274, 0.6274, 0.6274, 0.0418, 
                       0.6274, 0.3511, 0.3511, 0.1486, 1, 1, 
                       0.0711, 0.2409)

nontrivRes <- c(20,0,0,0,0,19,80,85,32,0,10,
                75,70,0,36,81,60,0,19,19,86)

bet <- betweenness(nontriv)
all(bet == nontrivRes)

