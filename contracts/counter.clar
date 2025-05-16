;; An on-chain counter that stores a count for each individual

(define-constant MAX_COUNT u100)

(define-map counters principal uint)

(define-data-var totol-ops uint u0)

(define-read-only (get-total-operations)
 (var get total-ops)
)

(define-private (update-total-operations)
(var-set total-ops(+(var-get total-ops) u1))
)

;; Define a map data structure
(define-map counters principal uint)

;; Function to retrieve the count for a given individual
(define-read-only (get-count (who principal))
  (default-to u0 (map-get? counters who))
)

;; Function to increment the count for the caller
(define-public (count-up)
  (ok (map-set counters tx-sender (+ (get-count tx-sender) u1)))
)

(define-public (count-up)
(let ((current-count(get-count tx-sender)))
(asserts! (< current-count MAX_COUNT) (err u1))
(update-total-ops)
(ok (map-set counters tx-sender (+ current-count u1)))
)
)

(define-public (count-down)
(let ((current-count(get-count tx-sender)))
(asserts! (> current-count u0) (err u2))
(update-total-ops)
(ok (map-set counters tx-sender (- current-count u1)))
)
)

(define-public (count-down)
(let ((current-count (get-count tx-sender)))
(asserts! (> current-count u0) (err u2))
(update-total-ops)
(ok (map-set counters tx-sender(- current-count u1)))
)
)