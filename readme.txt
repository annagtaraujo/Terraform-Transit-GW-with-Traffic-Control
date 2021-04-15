Construção de uma infraestrutura com 3 VPCs na AWS, onde cada VPC contém:
- 4 subnets públicas (1 por AZ)
- 4 subnets privadas (1 por AZ)
- 4 subnets database (1 por AZ)
- IGW
- NAT GW
- 1 route table pública
- 1 route table privada (contendo as subnets privadas e database)

Dados da infraestrutura:
Região : us-west-2 (Oregon)
Qtde de AZ : 4
Conexão : Transit Gateway com controle de tráfego
Representação gráfica:

----------                              ----------                                ----------
  VPC C   <---------------------------->   VPC A     <--------------------------->  VPC B
----------                              ----------                                ----------

