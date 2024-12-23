# Transit-Gateway
Here's a structured README template for your Terraform project showcasing the use of Transit Gateways (TGWs) with multiple VPCs. You can modify this to suit your style and include screenshots where appropriate.

---

# **Transit Gateway Architecture with Terraform**

## **Project Overview**
This Terraform project demonstrates how to configure and manage AWS Transit Gateway (TGW) for enabling communication between multiple VPCs. The project sets up three VPCs—**Production (Prod)**, **Development (Dev)**, and **Testing (Test)**—and integrates them using a Transit Gateway. It highlights the fundamental concepts of **TGW attachments** and **route table configurations** to ensure secure and efficient inter-VPC communication.

---

## **Architecture Diagram**
![image](https://github.com/user-attachments/assets/ea6c675c-65ab-49a1-98c3-d69fe7f98738)

The architecture includes:
- **Three VPCs**: Prod, Dev, and Test.
- **Transit Gateway**: Centralized connectivity hub.
- **TGW Attachments**: Connecting each VPC to the TGW.
- **Routing**: Configured to allow inter-VPC communication while maintaining isolation where necessary.

---

## **Features**
- Automated creation of VPCs with subnets (public and private).
- Transit Gateway setup for inter-VPC communication.
- TGW attachments for each VPC.
- Routing tables for traffic management between VPCs.


---

## **Prerequisites**
1. **Terraform**: Version >= 5.x
2. **AWS CLI**: Configured with appropriate permissions.
3. **AWS Account**: With permissions to create VPCs, TGWs, and related resources.

---


## **Resources Created**
- **3 VPCs**: Prod, Dev, Test
- **Subnets**: Public and private subnets for each VPC
- **Transit Gateway (TGW)**:
  - TGW Attachments: One for each VPC
  - TGW Route Tables: Configured for inter-VPC routing
- **Internet Gateway**: For public subnets (if applicable)


---

## **Routing Configuration**
| VPC       | Routes Configured               | Notes                     |
|-----------|---------------------------------|---------------------------|
| **Prod**  | Routes to Dev and Test VPCs    | Full communication setup |
| **Dev**   | Routes to Prod and Test VPCs   | Full communication setup |
| **Test**  | Routes to Prod and Dev VPCs    | Full communication setup |

---

## **Screenshots**
![image](https://github.com/user-attachments/assets/44c026ea-df01-4d7f-9ff1-5b317da43674)

- **Architecture Diagram**
- **Terraform Outputs**


---


## **Author**
- **Derrick Weil**  

