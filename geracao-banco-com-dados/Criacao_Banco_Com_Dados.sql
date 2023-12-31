USE [master]
GO
/****** Object:  Database [master_freios]    Script Date: 06/11/2023 21:06:02 ******/
CREATE DATABASE [master_freios]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'master_freios', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\master_freios.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'master_freios_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\master_freios_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [master_freios] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [master_freios].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [master_freios] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [master_freios] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [master_freios] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [master_freios] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [master_freios] SET ARITHABORT OFF 
GO
ALTER DATABASE [master_freios] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [master_freios] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [master_freios] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [master_freios] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [master_freios] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [master_freios] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [master_freios] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [master_freios] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [master_freios] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [master_freios] SET  DISABLE_BROKER 
GO
ALTER DATABASE [master_freios] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [master_freios] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [master_freios] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [master_freios] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [master_freios] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [master_freios] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [master_freios] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [master_freios] SET RECOVERY FULL 
GO
ALTER DATABASE [master_freios] SET  MULTI_USER 
GO
ALTER DATABASE [master_freios] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [master_freios] SET DB_CHAINING OFF 
GO
ALTER DATABASE [master_freios] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [master_freios] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [master_freios] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [master_freios] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'master_freios', N'ON'
GO
ALTER DATABASE [master_freios] SET QUERY_STORE = OFF
GO
USE [master_freios]
GO
/****** Object:  Table [dbo].[compra]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[compra](
	[id_compra] [int] IDENTITY(1,1) NOT NULL,
	[dt_compra] [datetime] NULL,
	[it_nota_fiscal] [int] NULL,
	[it_total] [money] NULL,
	[it_numero_parcelas] [int] NULL,
	[vc_status] [varchar](95) NULL,
	[id_fornecedor] [int] NULL,
	[id_tipo_pagamento] [int] NULL,
 CONSTRAINT [XPKcompra] PRIMARY KEY NONCLUSTERED 
(
	[id_compra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [ClusteredIndex-20231105-161109]    Script Date: 06/11/2023 21:06:03 ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20231105-161109] ON [dbo].[compra]
(
	[dt_compra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[venda]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[venda](
	[id_venda] [int] IDENTITY(1,1) NOT NULL,
	[dt_venda] [datetime] NULL,
	[it_nota_fiscal] [int] NULL,
	[it_total] [money] NULL,
	[it_numero_parcelas] [int] NULL,
	[vc_status] [varchar](95) NULL,
	[id_cliente] [int] NULL,
	[id_tipo_pagamento] [int] NULL,
	[it_a_vista] [int] NULL,
 CONSTRAINT [XPKvenda] PRIMARY KEY NONCLUSTERED 
(
	[id_venda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwResumoTransacoes]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwResumoTransacoes]
AS
SELECT        'Compra' AS TipoTransacao, id_compra AS IDTransacao, dt_compra AS DataTransacao, it_nota_fiscal AS NotaFiscal, it_total AS TotalTransacao, it_numero_parcelas AS NumeroParcelas, vc_status AS StatusTransacao, 
                         id_fornecedor AS IDFornecedor, id_tipo_pagamento AS IDTipoPagamento, NULL AS EAVista
FROM            dbo.compra
UNION ALL
SELECT        'Venda' AS TipoTransacao, id_venda AS IDTransacao, dt_venda AS DataTransacao, it_nota_fiscal AS NotaFiscal, NULL AS TotalTransacao, it_numero_parcelas AS NumeroParcelas, vc_status AS StatusTransacao, 
                         id_cliente AS IDCliente, id_tipo_pagamento AS IDTipoPagamento, it_a_vista AS EAVista
FROM            dbo.venda;
GO
/****** Object:  View [dbo].[vwRelatorioVendasMensais]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwRelatorioVendasMensais] 
AS
SELECT
   YEAR(v.dt_venda) as Ano,
   MONTH(v.dt_venda) as Mes,
   SUM(v.it_total) as TotalVendas
FROM
    venda v
GROUP BY
	YEAR(v.dt_venda),
	MONTH(v.dt_venda)
	



GO
/****** Object:  Table [dbo].[itens_compra]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[itens_compra](
	[id_itens_compra] [int] NOT NULL,
	[it_quantidade] [float] NULL,
	[it_valor] [money] NULL,
	[id_compra] [int] NOT NULL,
	[id_produto] [int] NOT NULL,
 CONSTRAINT [XPKitens_compra] PRIMARY KEY NONCLUSTERED 
(
	[id_itens_compra] ASC,
	[id_compra] ASC,
	[id_produto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[produto]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[produto](
	[id_produto] [int] IDENTITY(1,1) NOT NULL,
	[vc_nome] [varchar](95) NULL,
	[vc_descricao] [text] NULL,
	[pro_foto] [image] NULL,
	[it_valor_pago] [money] NULL,
	[it_valor_venda] [money] NULL,
	[it_quantidade] [float] NULL,
	[id_unidade_medida] [int] NULL,
	[id_categoria] [int] NULL,
	[id_subcategoria] [int] NULL,
 CONSTRAINT [XPKproduto] PRIMARY KEY NONCLUSTERED 
(
	[id_produto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20231105-161231]    Script Date: 06/11/2023 21:06:03 ******/
CREATE CLUSTERED INDEX [ClusteredIndex-20231105-161231] ON [dbo].[produto]
(
	[vc_nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwRelatorioComprasVendas]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwRelatorioComprasVendas] AS
SELECT
    p.vc_nome AS [Produto],
    c.dt_compra AS [Data_Compra],
    c.it_total AS [Total_Compra],
    v.dt_venda AS [Data_Venda],
    v.it_total AS [Total_Venda],
    (v.it_total - c.it_total) AS [Lucro_Por_Venda]
FROM
    [compra] c
INNER JOIN
    [itens_compra] ic ON c.id_compra = ic.id_compra
INNER JOIN
    [produto] p ON ic.id_produto = p.id_produto
LEFT JOIN
    [venda] v ON v.id_venda = ic.id_produto
GO
/****** Object:  Table [dbo].[itens_venda]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[itens_venda](
	[id_itens_venda] [int] NOT NULL,
	[it_quantidade] [float] NULL,
	[it_valor] [money] NULL,
	[id_venda] [int] NOT NULL,
	[id_produto] [int] NOT NULL,
 CONSTRAINT [XPKitens_venda] PRIMARY KEY NONCLUSTERED 
(
	[id_itens_venda] ASC,
	[id_venda] ASC,
	[id_produto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwDetalhesItensVenda]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwDetalhesItensVenda]
AS
SELECT        v.id_venda AS IDTransacao, iv.id_itens_venda AS IDItemVenda, p.vc_nome AS NomeProduto, iv.it_quantidade AS quantidade, iv.it_valor AS ValorUnitario
FROM            dbo.venda AS v INNER JOIN
                         dbo.itens_venda AS iv ON v.id_venda = iv.id_venda INNER JOIN
                         dbo.produto AS p ON iv.id_produto = p.id_produto
GO
/****** Object:  View [dbo].[vwProdutosEmEstoque]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwProdutosEmEstoque] AS
SELECT
    id_produto, vc_nome, it_quantidade
FROM produto
WHERE it_quantidade > 0;
GO
/****** Object:  View [dbo].[vwValorTotalEstoque]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwValorTotalEstoque] AS
SELECT
    SUM(it_quantidade * it_valor_pago) as ValorTotalEstoque
FROM produto
GO
/****** Object:  View [dbo].[vwDetalhesVendas]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwDetalhesVendas] AS
SELECT
    v.id_venda, v.dt_venda, iv.it_quantidade, p.vc_nome as nome_produto, iv.it_valor


FROM dbo.venda v

INNER JOIN itens_venda iv on v.id_venda = iv.id_venda 
INNER JOIN produto p on iv.id_produto = p.id_produto

GO
/****** Object:  Table [dbo].[categoria]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categoria](
	[id_categoria] [int] IDENTITY(1,1) NOT NULL,
	[vc_nome] [varchar](95) NULL,
 CONSTRAINT [XPKcategoria] PRIMARY KEY NONCLUSTERED 
(
	[id_categoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cliente]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cliente](
	[id_cliente] [int] IDENTITY(1,1) NOT NULL,
	[vc_nome] [varchar](95) NULL,
	[vc_cpf_cnpj] [varchar](95) NULL,
	[vc_rg_ie] [varchar](95) NULL,
	[vc_razao_social] [varchar](95) NULL,
	[vc_tipo] [varchar](20) NULL,
	[vc_cep] [varchar](20) NULL,
	[vc_endereco] [varchar](95) NULL,
	[vc_bairro] [varchar](95) NULL,
	[vc_fone] [varchar](95) NULL,
	[vc_cel] [varchar](95) NULL,
	[vc_email] [varchar](95) NULL,
	[vc_endereco_numero] [varchar](10) NULL,
	[vc_cidade] [char](18) NULL,
	[vc_estado] [char](18) NULL,
 CONSTRAINT [XPKcliente] PRIMARY KEY NONCLUSTERED 
(
	[id_cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20231105-161026]    Script Date: 06/11/2023 21:06:03 ******/
CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-20231105-161026] ON [dbo].[cliente]
(
	[vc_cpf_cnpj] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fornecedor]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fornecedor](
	[id_fornecedor] [int] IDENTITY(1,1) NOT NULL,
	[vc_nome] [varchar](95) NULL,
	[vc_razao_social] [varchar](95) NULL,
	[vc_inscricao_estadual] [varchar](95) NULL,
	[vc_cnpj] [varchar](95) NULL,
	[vc_cep] [varchar](95) NULL,
	[vc_endereco] [varchar](95) NULL,
	[vc_bairro] [varchar](95) NULL,
	[vc_fone] [varchar](95) NULL,
	[vc_cel] [varchar](95) NULL,
	[vc_email] [varchar](95) NULL,
	[vc_endereco_numero] [varchar](95) NULL,
	[vc_cidade] [varchar](95) NULL,
	[vc_estado] [varchar](95) NULL,
 CONSTRAINT [XPKfornecedor] PRIMARY KEY NONCLUSTERED 
(
	[id_fornecedor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClusteredIndex-20231105-161316]    Script Date: 06/11/2023 21:06:03 ******/
CREATE UNIQUE CLUSTERED INDEX [ClusteredIndex-20231105-161316] ON [dbo].[fornecedor]
(
	[vc_nome] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[parcelas_compra]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[parcelas_compra](
	[id_parcelas_compra] [int] NOT NULL,
	[it_valor] [money] NULL,
	[dt_pagamento] [date] NULL,
	[dt_vencimento] [date] NULL,
	[id_compra] [int] NOT NULL,
 CONSTRAINT [XPKparcelas_compra] PRIMARY KEY CLUSTERED 
(
	[id_parcelas_compra] ASC,
	[id_compra] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[parcelas_venda]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[parcelas_venda](
	[id_venda] [int] NOT NULL,
	[id_parcelas_venda] [int] NOT NULL,
	[it_valor] [money] NULL,
	[dt_pagamento] [date] NULL,
	[dt_vencimento] [date] NULL,
 CONSTRAINT [XPKparcelas_venda] PRIMARY KEY CLUSTERED 
(
	[id_venda] ASC,
	[id_parcelas_venda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[subcategoria]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[subcategoria](
	[id_subcategoria] [int] IDENTITY(1,1) NOT NULL,
	[vc_nome] [varchar](95) NULL,
	[id_categoria] [int] NULL,
 CONSTRAINT [XPKsubcategoria] PRIMARY KEY NONCLUSTERED 
(
	[id_subcategoria] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_pagamento]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipo_pagamento](
	[id_tipo_pagamento] [int] IDENTITY(1,1) NOT NULL,
	[vc_nome] [varchar](90) NULL,
 CONSTRAINT [XPKtipo_pagamento] PRIMARY KEY CLUSTERED 
(
	[id_tipo_pagamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[unidade_medida]    Script Date: 06/11/2023 21:06:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[unidade_medida](
	[id_unidade_medida] [int] IDENTITY(1,1) NOT NULL,
	[vc_nome] [varchar](95) NULL,
 CONSTRAINT [XPKmedida] PRIMARY KEY NONCLUSTERED 
(
	[id_unidade_medida] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[compra]  WITH CHECK ADD  CONSTRAINT [R_21] FOREIGN KEY([id_fornecedor])
REFERENCES [dbo].[fornecedor] ([id_fornecedor])
GO
ALTER TABLE [dbo].[compra] CHECK CONSTRAINT [R_21]
GO
ALTER TABLE [dbo].[compra]  WITH CHECK ADD  CONSTRAINT [R_24] FOREIGN KEY([id_tipo_pagamento])
REFERENCES [dbo].[tipo_pagamento] ([id_tipo_pagamento])
GO
ALTER TABLE [dbo].[compra] CHECK CONSTRAINT [R_24]
GO
ALTER TABLE [dbo].[itens_compra]  WITH CHECK ADD  CONSTRAINT [R_15] FOREIGN KEY([id_compra])
REFERENCES [dbo].[compra] ([id_compra])
GO
ALTER TABLE [dbo].[itens_compra] CHECK CONSTRAINT [R_15]
GO
ALTER TABLE [dbo].[itens_compra]  WITH CHECK ADD  CONSTRAINT [R_17] FOREIGN KEY([id_produto])
REFERENCES [dbo].[produto] ([id_produto])
GO
ALTER TABLE [dbo].[itens_compra] CHECK CONSTRAINT [R_17]
GO
ALTER TABLE [dbo].[itens_venda]  WITH CHECK ADD  CONSTRAINT [R_13] FOREIGN KEY([id_venda])
REFERENCES [dbo].[venda] ([id_venda])
GO
ALTER TABLE [dbo].[itens_venda] CHECK CONSTRAINT [R_13]
GO
ALTER TABLE [dbo].[itens_venda]  WITH CHECK ADD  CONSTRAINT [R_14] FOREIGN KEY([id_produto])
REFERENCES [dbo].[produto] ([id_produto])
GO
ALTER TABLE [dbo].[itens_venda] CHECK CONSTRAINT [R_14]
GO
ALTER TABLE [dbo].[parcelas_compra]  WITH CHECK ADD  CONSTRAINT [R_25] FOREIGN KEY([id_compra])
REFERENCES [dbo].[compra] ([id_compra])
GO
ALTER TABLE [dbo].[parcelas_compra] CHECK CONSTRAINT [R_25]
GO
ALTER TABLE [dbo].[parcelas_venda]  WITH CHECK ADD  CONSTRAINT [R_22] FOREIGN KEY([id_venda])
REFERENCES [dbo].[venda] ([id_venda])
GO
ALTER TABLE [dbo].[parcelas_venda] CHECK CONSTRAINT [R_22]
GO
ALTER TABLE [dbo].[produto]  WITH CHECK ADD  CONSTRAINT [R_11] FOREIGN KEY([id_categoria])
REFERENCES [dbo].[categoria] ([id_categoria])
GO
ALTER TABLE [dbo].[produto] CHECK CONSTRAINT [R_11]
GO
ALTER TABLE [dbo].[produto]  WITH CHECK ADD  CONSTRAINT [R_12] FOREIGN KEY([id_subcategoria])
REFERENCES [dbo].[subcategoria] ([id_subcategoria])
GO
ALTER TABLE [dbo].[produto] CHECK CONSTRAINT [R_12]
GO
ALTER TABLE [dbo].[produto]  WITH CHECK ADD  CONSTRAINT [R_9] FOREIGN KEY([id_unidade_medida])
REFERENCES [dbo].[unidade_medida] ([id_unidade_medida])
GO
ALTER TABLE [dbo].[produto] CHECK CONSTRAINT [R_9]
GO
ALTER TABLE [dbo].[subcategoria]  WITH CHECK ADD  CONSTRAINT [R_10] FOREIGN KEY([id_categoria])
REFERENCES [dbo].[categoria] ([id_categoria])
GO
ALTER TABLE [dbo].[subcategoria] CHECK CONSTRAINT [R_10]
GO
ALTER TABLE [dbo].[venda]  WITH CHECK ADD  CONSTRAINT [R_20] FOREIGN KEY([id_cliente])
REFERENCES [dbo].[cliente] ([id_cliente])
GO
ALTER TABLE [dbo].[venda] CHECK CONSTRAINT [R_20]
GO
ALTER TABLE [dbo].[venda]  WITH CHECK ADD  CONSTRAINT [R_23] FOREIGN KEY([id_tipo_pagamento])
REFERENCES [dbo].[tipo_pagamento] ([id_tipo_pagamento])
GO
ALTER TABLE [dbo].[venda] CHECK CONSTRAINT [R_23]
GO
USE [master]
GO
ALTER DATABASE [master_freios] SET  READ_WRITE 
GO
