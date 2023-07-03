# Using DBT to transform NYC Taxi Trips Data into a BI-ready star schema.

## Data transformation stages
A `taxi_trips` interface was created as a DBT macro called `get_trip_fields` in order to achieve fields consistency for different kind of taxi types (yellow/green). Then all of these trips are merged into a `fact_trips` table that aggregates `dim_zones` as a dimension so that pickup and dropoff locations data are properly defined.

![Data transformation diagram](/assets/diagram.png)

## Data's source and structure

Data in BigQuery datasets is transformed to models in DBT. This is the structure of the raw data imported into DBT:

* vendorid: A code indicating the TPEP provider that provided the record.
  * 1= Creative Mobile Technologies, LLC
  * 2= VeriFone Inc.
* tpep_pickup_datetime: The date and time when the meter was engaged. 
* tpep_dropoff_datetime: The date and time when the meter was disengaged. 
* Passenger_count: The number of passengers in the vehicle. (driver-entered value).
* Trip_distance: The elapsed trip distance in miles reported by the taximeter.
* PULocationID: TLC Taxi Zone in which the taximeter was engaged.
* DOLocationID: TLC Taxi Zone in which the taximeter was disengaged.
* RateCodeID: The final rate code in effect at the end of the trip.
  * 1= Standard rate
  * 2= JFK
  * 3= Newark
  * 4= Nassau or Westchester
  * 5= Negotiated fare
  * 6= Group ride
* Store_and_fwd_flag: This flag indicates whether the trip record was held in vehicle
memory before sending to the vendor.
* Payment_type: A numeric code signifying how the passenger paid for the trip.
  * 1= Credit card
  * 2= Cash
  * 3= No charge
  * 4= Dispute
  * 5= Unknown
  * 6= Voided trip
* Fare_amount: The time-and-distance fare calculated by the meter.
* Extra: Miscellaneous extras and surcharges.
* MTA_tax: $0.50 MTA tax that is automatically triggered based on the metered
rate in use.
* Improvement_surcharge: $0.30 improvement surcharge assessed trips at the flag drop. The improvement surcharge began being levied in 2015.
* Tip_amount: Tip amount – This field is automatically populated for credit card
tips. Cash tips are not included.
* Tolls_amount: Total amount of all tolls paid in trip.
* Total_amount: The total amount charged to passengers. Does not include cash tips.
* Congestion_Surcharge: Total amount collected in trip for NYS congestion surcharge.
* Airport_fee: $1.25 for pick up only at LaGuardia and John F. Kennedy Airports.

Data extracted from: https://www.nyc.gov/site/tlc/about/tlc-trip-record-data.page.

## How was the structure defined into a BI-ready star schema
The star schema's structure was defined by the need to answer the following BI questions and needs:

* Is there a correlation between trip distance and fare amount?
* What is the average tip amount for different payment types?
* Which pickup and dropoff locations are most frequent?
* How does the total amount charged vary with time of day or day of the week?
* Are there differences in trip fares between trips with the "Store_and_fwd_flag" enabled and disabled?
* How does passenger count vary with time?

The raw data itself only provides ids for pickup and dropoff locations. This is why it was needed to a `zones` dimension to our star schema to provide context and more friendly data. The `zones` dimension provides the following data about locations:

* borough
* zone
* service_zone

With this data we can then now exactly know where trips are started and ended.
