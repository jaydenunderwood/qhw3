(define (domain sokorobotto)
  (:requirements :typing)
  (:types shipment order location robot pallette saleitem transport - object
        robot pallette - transport)
  (:predicates 
        (ships ?s - shipment ?o - order)
        (orders ?o - order ?i - saleitem)
        (unstarted ?s - shipment)
        (packing-location ?l - location)
        (available ?l - location)
        (contains ?p - pallette ?i - saleitem)
        (free ?r - robot)
        (connected ?l - location ?l - location)
        (at ?t - transport ?l - location)
        (no-robot ?l - location)
        (no-pallette ?l - location)
        (includes ?s - shipment ?i - saleitem))
        
    (:action move-robot
        :parameters (?r - robot ?l1 ?l2 - location)
        :precondition (and (at ?r ?l1)
                            (no-robot ?l2)
                            (connected ?l1 ?l2)
                            (free ?r))
        :effect (and
            (not (at ?r ?l1))
            (at ?r ?l2)
            (no-robot ?l1)
            (not (no-robot ?l2)))
        )
        
    (:action pickup-pallette
        :parameters (?r - robot ?l - location ?p - pallette ?i - saleitem ?o - order)
        :precondition (and (at ?r ?l)
                            (at ?p ?l)
                            (orders ?o ?i)
                            (contains ?p ?i))
        :effect
            (not (free ?r))
    )
    
    (:action move-robot-pallette
        :parameters (?r - robot ?p - pallette ?l1 - location ?l2 - location)
        :precondition (and (at ?r ?l1)
                            (at ?p ?l1)
                            (no-robot ?l2)
                            (no-pallette ?l2)
                            (connected ?l1 ?l2)
                            (not (free ?r)))
        :effect (and
            (not (at ?r ?l1))
            (not (at ?p ?l1))
            (at ?r ?l2)
            (at ?p ?l2)
            (no-robot ?l1)
            (no-pallette ?l1)
            (not (no-robot ?l2))
            (not (no-pallette ?l2))
        )
    )
    
    (:action putdown-pallatte
        :parameters (?r - robot ?l - location)
        :precondition (and (at ?r ?l)
                            (not (free ?r)))
        :effect
            (free ?r)
    )
     
     (:action add-shipment
         :parameters (?r - robot ?p - pallette ?l - location ?s - shipment ?i - saleitem ?o - order)
         :precondition (and (at ?r ?l)
                            (not (free ?r))
                            (at ?p ?l)
                            (packing-location ?l)
                            (orders ?o ?i)
                            (contains ?p ?i)
                            (not (includes ?s ?i))
                            (ships ?s ?o))
         :effect (and
                (not (contains ?p ?i))
                (includes ?s ?i)
         )
     )   
)

