# Transit-Gateway
Here's a structured README template for your Terraform project showcasing the use of Transit Gateways (TGWs) with multiple VPCs. You can modify this to suit your style and include screenshots where appropriate.

---

# **Transit Gateway Architecture with Terraform**

## **Project Overview**
This Terraform project demonstrates how to configure and manage AWS Transit Gateway (TGW) for enabling communication between multiple VPCs. The project sets up three VPCs—**Production (Prod)**, **Development (Dev)**, and **Testing (Test)**—and integrates them using a Transit Gateway. It highlights the fundamental concepts of **TGW attachments** and **route table configurations** to ensure secure and efficient inter-VPC communication.

---

## **Architecture Diagram**
*(Include a diagram or a description here)*  
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
- Modular and reusable Terraform code for scalability.

---

## **Prerequisites**
1. **Terraform**: Version >= 1.x
2. **AWS CLI**: Configured with appropriate permissions.
3. **AWS Account**: With permissions to create VPCs, TGWs, and related resources.

---

## **Usage**

### **Step 1: Clone the Repository**
```bash
git clone <repository_url>
cd <repository_folder>
```

### **Step 2: Update Variables**
Modify the `variables.tf` file to customize:
- VPC CIDR blocks.
- Subnet CIDRs.
- TGW configurations.

### **Step 3: Initialize Terraform**
```bash
terraform init
```

### **Step 4: Apply the Terraform Plan**
```bash
terraform apply
```
Confirm the execution by typing `yes` when prompted.

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
- **AWS Console Views (TGW, VPCs, Routes)**

---


## **Author**
- **Derrick Weil**  
*(Optional: Add your contact details, GitHub profile, or LinkedIn link)*

---

Feel free to adjust or expand this template based on your audience and additional project features.
