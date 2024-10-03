# FineFlierDB
TSQL DB for a Fly Company

# Motivation for Choosing

The decision to manage a database for an airport is motivated by the necessity to organize and control a series of complex and vital processes for the daily operations of an airport. **FineFlier** aims to provide an efficient and reliable solution for managing all aspects related to airport operations, including flights, passengers, crews, services, and more. A well-designed database can facilitate the effective management of these processes by providing accurate and real-time updated data.

## Database Description

**FineFlier** is a relational database that manages various aspects of airport activity, divided into multiple entities and relationships among them. It is designed to be scalable and flexible, allowing for the addition and modification of data as operational requirements evolve.

## Key Features

FineFlier offers a wide range of functionalities to efficiently manage airport operations, including:

- **Airline Management**: FineFlier stores information about the airlines operating in the airport, including contact details and the address of their headquarters.
- **Flight Scheduling and Management**: The database stores information about destinations, flights, flight schedules, departures, and arrivals, facilitating the planning and monitoring of flight activities.
- **Passenger and Ticket Management**: FineFlier allows for the registration and management of passenger data, including personal information, tickets, and associated baggage.
- **Airport Staff Management**: The database stores details about airport personnel, including employees and their roles, facilitating human resource management.
- **Airport Services and Shops**: FineFlier manages information about services available in the airport, such as car rentals, shops, and restaurants, to provide a complete experience for passengers and visitors.
- **Complaint and Feedback Management**: The database enables the registration and management of passenger complaints and feedback to continuously improve airport services.

## Benefits of Using the FineFlier Database

FineFlier brings several benefits to airport operations:

- **Operational Efficiency**: Centralizing and organizing key data in a relational database facilitates the management and monitoring of airport operations.
- **Accuracy and Consistency**: Using a database reduces the risk of human error and ensures data consistency across the organization.
- **Rapid Response**: Quick and easy access to updated information allows airport staff to respond promptly to passenger needs and manage emergency situations efficiently.
- **Enhanced Passenger Experience**: By efficiently managing services and passenger feedback, FineFlier contributes to improving the overall travel experience at the airport.

## Table Description and Diagram

### Airlines Table Description

The Airlines table stores information about airlines.

**Columns**:

- `ID_Company (INT, PK)`: The unique identifier for the airline.
- `CompanyName (NVARCHAR(100))`: The name of the airline.
- `IATA_Code (NVARCHAR(3), UNIQUE)`: The IATA code of the airline.
- `ICAO_Code (NVARCHAR(4), UNIQUE)`: The ICAO code of the airline.
- `HeadquartersAddress (NVARCHAR(100))`: The address of the airline's headquarters.
