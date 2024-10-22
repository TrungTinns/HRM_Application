
# HRM System Project Description

## Introduction

This project focuses on developing a comprehensive, efficient, and scalable **Human Resource Management (HRM) System** that meets the needs of human resource management in modern business environments. The system is built on a Java platform, utilizing microservices architecture to enhance scalability and maintainability.

## Objectives

**General Objective:** 

- To develop a **comprehensive, efficient, and scalable HRM system** based on Java.

**Specific Objectives:**

- **Functionality:** Build modules to manage employee information, recruitment, payroll, work time management, reporting, and human resource data analytics.
- **Technology:**
    - Apply microservices architecture to enhance scalability and maintainability.
    - Develop the backend using Spring Boot for high performance and large data processing.
    - Build a cross-platform frontend using Flutter to create a user-friendly interface.
    - Implement an effective database to ensure data consistency and security.
- **Development Process:**
    - Adopt Agile methodology for effective project management.
    - Conduct unit and integration testing to ensure software quality.
    - Create detailed technical documentation and user guides.
- **Performance and Scalability:**
    - Optimize system performance to handle large data volumes and multiple concurrent users.
    - Design the system to be scalable to meet business growth needs.

## Research Scope

- **Overview of HRM Systems:** Research existing HRM systems to understand their functionalities, best practices, and limitations.
- **Requirements Analysis:** Gather and document stakeholder needs and expectations through user interviews and expert consultations.
- **System Design and Architecture:** Utilize microservices architecture with Spring Boot for the backend and Flutter for the frontend.
- **Technology Framework:** Evaluate the necessary frameworks and tools to build and deploy the HRM system.
- **Deployment and Testing:** Plan development phases, conduct iterative testing, and ensure the system meets all functional and performance requirements.
- **User Training and Support:** Develop a comprehensive training and support plan for end users.
- **Evaluation and Optimization:** Assess system performance and effectiveness post-deployment, gather user feedback, and identify areas for improvement.

## Research Methodology

- **Agile and Scrum:** Implement Agile methodology with one-week sprints, combining continuous research activities. Use the Scrum framework in JIRA to manage the project workflow.
- **Supplementary Research:** Employ other research methods such as case studies and user surveys.

## System Architecture

The project utilizes microservices architecture, divided into independent services as follows:

- **Discovery Server (Eureka Server):** Manages and registers services, allowing the application to automatically discover and connect with other services.
- **API Gateway:** Acts as a single entry point for all client requests, managing request routing, load balancing, security, and caching.
- **Employee Service:** Manages all employee-related data, including personal information, job roles, etc.
- **Recruitment Service:** Handles the recruitment process, including managing candidate information and applications.
- **TimeSheet Service:** Tracks employee working hours, including clock-in/out times, overtime, and leave requests.
- **Payroll Service:** Calculates and processes employee salaries, using data from both the Employee Service and TimeSheet Service.

## Inter-Service Communication

The project uses **Kafka** to facilitate communication between different services. Kafka allows services to publish and subscribe to data streams, enabling a **reliable, scalable, and loosely coupled** system.

## Technologies Used

**Frontend:**

- **Flutter:** A cross-platform mobile application development framework that allows for consistent user interfaces across devices.

**Backend:**

- **Spring Boot:** A Java application development platform providing automatic configuration, embedded server integration, and simplified dependency management.

**Database:**

- **Firestore (NoSQL):** A flexible and scalable database that provides a document-oriented data model, real-time data synchronization, and offline support.

**Others:**

- **Axon Framework and Domain-Driven Design (DDD):** Used to simplify the implementation of complex, scalable, and maintainable Java applications.

## Expected Results

The project aims to create a **modern HRM system** that meets the needs of contemporary businesses. This system is designed to be **user-friendly, secure, efficient, and scalable**, helping organizations manage their human resources more effectively.

## Project Status

The project is currently under development. Some functionalities have been completed, including:

- Microservices architecture
- Backend development with Spring Boot (Employee Service, Recruitment Service, TimeSheet Service)
- Frontend development with Flutter (user interfaces for employee management, recruitment, and time tracking)

However, some issues remain unresolved:

- TimeSheet API integration is incomplete.
- Payroll Service has not yet been developed.

## Future Development

- Complete TimeSheet API integration.
- Develop the Payroll Service.

## Notes

- Detailed information about the system's functionalities, use case diagrams, ERD diagrams, and screenshots can be found in the provided source documentation.

## Conclusion

The HRM project is an ambitious initiative aimed at creating a comprehensive and modern human resource management system. While there are still some issues to address, the project has made significant progress. With continued development and completion of the remaining functionalities, the HRM system promises to be an effective solution for human resource management in modern businesses.
