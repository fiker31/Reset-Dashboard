USE [master]
GO
/****** Object:  Database [MerchantAppDB]    Script Date: 6/29/2023 4:13:09 PM ******/
CREATE DATABASE [MerchantAppDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MerchantAppDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MerchantAppDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MerchantAppDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MerchantAppDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MerchantAppDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MerchantAppDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MerchantAppDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MerchantAppDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MerchantAppDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MerchantAppDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MerchantAppDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [MerchantAppDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MerchantAppDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MerchantAppDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MerchantAppDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MerchantAppDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MerchantAppDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MerchantAppDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MerchantAppDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MerchantAppDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MerchantAppDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MerchantAppDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MerchantAppDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MerchantAppDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MerchantAppDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MerchantAppDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MerchantAppDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MerchantAppDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MerchantAppDB] SET RECOVERY FULL 
GO
ALTER DATABASE [MerchantAppDB] SET  MULTI_USER 
GO
ALTER DATABASE [MerchantAppDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MerchantAppDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MerchantAppDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MerchantAppDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MerchantAppDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MerchantAppDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MerchantAppDB', N'ON'
GO
ALTER DATABASE [MerchantAppDB] SET QUERY_STORE = OFF
GO
USE [MerchantAppDB]
GO
/****** Object:  Table [dbo].[AppVersionMerchantApp]    Script Date: 6/29/2023 4:13:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppVersionMerchantApp](
	[LatesVersion] [nvarchar](50) NOT NULL,
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_App_Version_Fuel] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MerchantAppMerchantInfo]    Script Date: 6/29/2023 4:13:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MerchantAppMerchantInfo](
	[Id] [uniqueidentifier] NOT NULL,
	[Shortcode] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[KYC] [nvarchar](max) NULL,
	[Status] [nvarchar](10) NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [nvarchar](10) NOT NULL,
	[UpdateUser] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_MerchantInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MerchantAppOTP]    Script Date: 6/29/2023 4:13:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MerchantAppOTP](
	[MerchantPhone] [varchar](50) NOT NULL,
	[MerchantOTP] [varchar](10) NOT NULL,
	[MerchantExpTime] [datetime] NOT NULL,
 CONSTRAINT [PK_OTP] PRIMARY KEY CLUSTERED 
(
	[MerchantPhone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MerchantAppSalersList]    Script Date: 6/29/2023 4:13:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MerchantAppSalersList](
	[Id] [uniqueidentifier] NOT NULL,
	[SalersPhone] [nvarchar](50) NOT NULL,
	[EncryptionKey] [nvarchar](500) NOT NULL,
	[Shortcode] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](10) NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [nvarchar](10) NOT NULL,
	[UpdateUser] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_SalersList] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MerchantAppSimulation]    Script Date: 6/29/2023 4:13:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MerchantAppSimulation](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Phone] [nvarchar](150) NOT NULL,
	[MerchantShortCode] [nvarchar](150) NOT NULL,
	[MerchantName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_MerchantSimulation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MerchantAppTXN]    Script Date: 6/29/2023 4:13:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MerchantAppTXN](
	[Id] [uniqueidentifier] NOT NULL,
	[Shortcode] [nvarchar](50) NOT NULL,
	[Phone] [nvarchar](50) NOT NULL,
	[Amount] [decimal](15, 2) NOT NULL,
	[TransactionId] [nvarchar](100) NOT NULL,
	[Status] [nvarchar](10) NOT NULL,
	[SalersPhone] [nvarchar](100) NULL,
	[TransactionEndDate] [datetime] NOT NULL,
	[InsertDate] [datetime] NULL,
	[UpdateDate] [datetime] NULL,
	[InsertUser] [nvarchar](10) NULL,
	[UpdateUser] [nvarchar](10) NULL,
 CONSTRAINT [PK_TXN] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MerchantAppMerchantInfo] ADD  CONSTRAINT [DF_MerchantInfo_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[MerchantAppSalersList] ADD  CONSTRAINT [DF_SalersList_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[MerchantAppSalersList] ADD  CONSTRAINT [DF_SalersList_Shortcode]  DEFAULT (newid()) FOR [Shortcode]
GO
ALTER TABLE [dbo].[MerchantAppTXN] ADD  CONSTRAINT [DF_TXN_Id]  DEFAULT (newid()) FOR [Id]
GO
USE [master]
GO
ALTER DATABASE [MerchantAppDB] SET  READ_WRITE 
GO
