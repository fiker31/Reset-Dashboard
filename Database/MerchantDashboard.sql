USE [master]
GO
/****** Object:  Database [MerchantDashboard]    Script Date: 9/20/2023 1:56:34 AM ******/
CREATE DATABASE [MerchantDashboard]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SDC', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MerchantDashboard.mdf' , SIZE = 9216KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SDC_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MerchantDashboard_log.ldf' , SIZE = 32448KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MerchantDashboard] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MerchantDashboard].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MerchantDashboard] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MerchantDashboard] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MerchantDashboard] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MerchantDashboard] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MerchantDashboard] SET ARITHABORT OFF 
GO
ALTER DATABASE [MerchantDashboard] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MerchantDashboard] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MerchantDashboard] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MerchantDashboard] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MerchantDashboard] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MerchantDashboard] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MerchantDashboard] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MerchantDashboard] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MerchantDashboard] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MerchantDashboard] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MerchantDashboard] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MerchantDashboard] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MerchantDashboard] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MerchantDashboard] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MerchantDashboard] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MerchantDashboard] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MerchantDashboard] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MerchantDashboard] SET RECOVERY FULL 
GO
ALTER DATABASE [MerchantDashboard] SET  MULTI_USER 
GO
ALTER DATABASE [MerchantDashboard] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MerchantDashboard] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MerchantDashboard] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MerchantDashboard] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MerchantDashboard] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MerchantDashboard] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MerchantDashboard', N'ON'
GO
ALTER DATABASE [MerchantDashboard] SET QUERY_STORE = OFF
GO
USE [MerchantDashboard]
GO
/****** Object:  Schema [HangFire]    Script Date: 9/20/2023 1:56:34 AM ******/
CREATE SCHEMA [HangFire]
GO
/****** Object:  View [dbo].[LoanStatementView]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[LoanStatementView]
AS
SELECT dbo.LoanBasicInformation.LoanId, dbo.LoanBasicInformation.EmployeeId, dbo.LoanRepayment.PaidInterest, 
           dbo.LoanRepayment.PaidPrincipal, dbo.LoanRepayment.TransactionDate, dbo.LoanBasicInformation.RemainingLoanAmount, 
           dbo.LoanBasicInformation.RemainingInterestAmount, dbo.LoanRepayment.Type, dbo.LoanBasicInformation.Status, 
           dbo.LoanRepayment.Status AS Expr1
FROM   dbo.LoanBasicInformation INNER JOIN
           dbo.LoanRepayment ON dbo.LoanBasicInformation.LoanId = dbo.LoanRepayment.LoanId
GO
/****** Object:  Table [dbo].[AuditColumns]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditColumns](
	[ColumnID] [bigint] NOT NULL,
	[TableID] [bigint] NOT NULL,
	[ColumnName] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditLog]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLog](
	[AuditLogID] [bigint] NOT NULL,
	[TableID] [bigint] NOT NULL,
	[RowsAffected] [bit] NOT NULL,
	[Event] [char](1) NOT NULL,
	[EventDateTime] [datetime] NOT NULL,
	[UserName] [varchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditLogDetail]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditLogDetail](
	[AuditLogDetailID] [bigint] NOT NULL,
	[AuditLogID] [bigint] NOT NULL,
	[RowKey] [varchar](512) NOT NULL,
	[ColumnID] [bigint] NOT NULL,
	[OldValue] [varchar](4000) NULL,
	[NewValue] [varchar](4000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditTables]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditTables](
	[TableID] [bigint] NOT NULL,
	[TableName] [varchar](255) NOT NULL,
	[Description] [varchar](255) NOT NULL,
	[PKeyField] [varchar](50) NOT NULL,
	[AuditInserts] [bit] NOT NULL,
	[AuditUpdates] [bit] NOT NULL,
	[AuditDeletes] [bit] NOT NULL,
	[UserColumn] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Branch]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Branch](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[DistrictID] [bigint] NULL,
	[T24Code] [nvarchar](50) NULL,
	[Address] [nvarchar](150) NULL,
	[Contact] [nvarchar](150) NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_Branch_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BusPeriod]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BusPeriod](
	[RowId] [bigint] NOT NULL,
	[BusinessPeriod] [char](9) NOT NULL,
	[PStatus] [tinyint] NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[District]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[District](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NULL,
	[Address] [nvarchar](150) NULL,
	[Contact] [nvarchar](50) NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_District] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntCapability]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntCapability](
	[CapabilityId] [bigint] NOT NULL,
	[CapabilityName] [varchar](50) NOT NULL,
	[MenuItemId] [bigint] NOT NULL,
	[AccessType] [tinyint] NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntMenuItem]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntMenuItem](
	[MenuItemId] [bigint] NOT NULL,
	[MenuItemName] [varchar](50) NOT NULL,
	[Description] [varchar](250) NULL,
	[URL] [varchar](250) NULL,
	[ParentMenuItemId] [bigint] NULL,
	[DisplaySequence] [tinyint] NOT NULL,
	[IsAlwaysEnabled] [bit] NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntPasswordHistory]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntPasswordHistory](
	[Id] [bigint] NOT NULL,
	[UserAccountName] [varchar](250) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[AppName] [varchar](50) NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[Version] [binary](8) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntRole]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntRole](
	[RoleId] [bigint] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_EntRole] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntRoleCapability]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntRoleCapability](
	[RoleCapabilityId] [bigint] IDENTITY(1,1) NOT NULL,
	[RoleId] [bigint] NOT NULL,
	[CapabilityId] [bigint] NOT NULL,
	[AccessFlag] [tinyint] NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_EntRoleCapability] PRIMARY KEY CLUSTERED 
(
	[RoleCapabilityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntRoleUserAccount]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntRoleUserAccount](
	[RoleUserAccountId] [bigint] IDENTITY(1,1) NOT NULL,
	[RoleId] [bigint] NOT NULL,
	[UserAccountId] [bigint] NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_EntRoleUserAccount] PRIMARY KEY CLUSTERED 
(
	[RoleUserAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EntUserAccount]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EntUserAccount](
	[UserAccountId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserAccountName] [varchar](50) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[Phone] [varchar](100) NOT NULL,
	[Shortcode] [varchar](250) NULL,
	[Status] [bit] NOT NULL,
	[UserPassword] [varchar](50) NOT NULL,
	[PWDChangeDate] [datetime] NOT NULL,
	[IsNewPassword] [bit] NULL,
	[IsLocked] [bit] NOT NULL,
	[PAsswordAttemptNo] [tinyint] NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_EntUserAccount_1] PRIMARY KEY CLUSTERED 
(
	[UserAccountId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Holiday]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Holiday](
	[Id] [bigint] NOT NULL,
	[HolidayName] [varchar](50) NOT NULL,
	[HolidayDate] [datetime] NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogInOut]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogInOut](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[LogInDT] [datetime] NOT NULL,
	[LogOutDT] [datetime] NOT NULL,
	[Status] [char](1) NOT NULL,
	[UserHost] [varchar](50) NOT NULL,
 CONSTRAINT [PK_LogInOut] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MerchantAppMerchantInfo]    Script Date: 9/20/2023 1:56:34 AM ******/
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
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_MerchantInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MerchantAppSalersList]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MerchantAppSalersList](
	[Id] [uniqueidentifier] NOT NULL,
	[SalersPhone] [varchar](50) NOT NULL,
	[EncryptionKey] [varchar](500) NOT NULL,
	[Shortcode] [varchar](50) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_MerchantAppSalersList] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MerchantAppSimulation]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MerchantAppSimulation](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Phone] [nvarchar](150) NOT NULL,
	[MerchantShortCode] [nvarchar](150) NOT NULL,
	[MerchantName] [nvarchar](50) NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_MerchantSimulation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MerchantAppTXN]    Script Date: 9/20/2023 1:56:34 AM ******/
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
	[SalersPhone] [nvarchar](100) NOT NULL,
	[TransactionEndDate] [datetime] NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NOT NULL,
	[InsertUser] [varchar](250) NOT NULL,
	[UpdateUser] [varchar](250) NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_MerchantAppTXN] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SysPar]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysPar](
	[GLCodeLen] [tinyint] NOT NULL,
	[SLCodeLen] [tinyint] NOT NULL,
	[MinPWDLen] [tinyint] NOT NULL,
	[MinLoginIdLen] [tinyint] NOT NULL,
	[TotalCapital] [money] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SysSecurityParm]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SysSecurityParm](
	[LoginIdMinLength] [tinyint] NOT NULL,
	[PasswordMinLength] [tinyint] NOT NULL,
	[PasswordMustHaveDigit] [bit] NOT NULL,
	[PasswordMustHaveLowerCase] [bit] NOT NULL,
	[PasswordMustHaveUpperCase] [bit] NOT NULL,
	[PasswordMustHaveSpecialChar] [bit] NOT NULL,
	[AllowedUnsuccessfulAttempts] [tinyint] NOT NULL,
	[PasswordInterval] [tinyint] NOT NULL,
	[PasswordHistory] [tinyint] NOT NULL,
	[UpdateUser] [varchar](10) NOT NULL,
	[UpdateDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Branch] ON 

INSERT [dbo].[Branch] ([ID], [Name], [DistrictID], [T24Code], [Address], [Contact], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (1, N'Mexico', 1, N'1212', N'Mexico Square', N'1212', CAST(N'2023-07-19T04:02:52.627' AS DateTime), CAST(N'2023-07-19T04:02:52.627' AS DateTime), N'system', N'system')
SET IDENTITY_INSERT [dbo].[Branch] OFF
GO
SET IDENTITY_INSERT [dbo].[District] ON 

INSERT [dbo].[District] ([ID], [Name], [Address], [Contact], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (1, N'Addis Ababa', N'Mexico', N'1212', CAST(N'2023-07-19T04:02:32.663' AS DateTime), CAST(N'2023-07-19T04:02:32.663' AS DateTime), N'system', N'system')
SET IDENTITY_INSERT [dbo].[District] OFF
GO
INSERT [dbo].[EntCapability] ([CapabilityId], [CapabilityName], [MenuItemId], [AccessType], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (1, N'Roles', 4, 0, CAST(N'2023-07-19T04:02:17.517' AS DateTime), CAST(N'2023-07-19T04:02:17.517' AS DateTime), N'system', N'system')
INSERT [dbo].[EntCapability] ([CapabilityId], [CapabilityName], [MenuItemId], [AccessType], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (2, N'Users', 3, 1, CAST(N'2023-07-19T04:02:17.517' AS DateTime), CAST(N'2023-07-19T04:02:17.517' AS DateTime), N'system', N'system')
INSERT [dbo].[EntCapability] ([CapabilityId], [CapabilityName], [MenuItemId], [AccessType], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (3, N'Backup', 5, 2, CAST(N'2023-07-19T04:02:17.517' AS DateTime), CAST(N'2023-07-19T04:02:17.517' AS DateTime), N'system', N'system')
INSERT [dbo].[EntCapability] ([CapabilityId], [CapabilityName], [MenuItemId], [AccessType], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (4, N'Restore', 6, 1, CAST(N'2023-07-19T04:02:17.517' AS DateTime), CAST(N'2023-07-19T04:02:17.517' AS DateTime), N'system', N'system')
INSERT [dbo].[EntCapability] ([CapabilityId], [CapabilityName], [MenuItemId], [AccessType], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10, N'Salers', 14, 0, CAST(N'2023-07-19T04:02:17.517' AS DateTime), CAST(N'2023-07-19T04:02:17.517' AS DateTime), N'system', N'system')
GO
INSERT [dbo].[EntMenuItem] ([MenuItemId], [MenuItemName], [Description], [URL], [ParentMenuItemId], [DisplaySequence], [IsAlwaysEnabled], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (8, N'My Salers', N'My Salers Setting', NULL, 1, 3, 0, CAST(N'2023-07-19T04:02:00.360' AS DateTime), CAST(N'2023-07-19T04:02:00.360' AS DateTime), N'system', N'system')
INSERT [dbo].[EntMenuItem] ([MenuItemId], [MenuItemName], [Description], [URL], [ParentMenuItemId], [DisplaySequence], [IsAlwaysEnabled], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (1, N'Home', N'Go back to the home page', N'Home/Default.aspx', NULL, 1, 1, CAST(N'2023-07-19T04:02:00.360' AS DateTime), CAST(N'2023-07-19T04:02:00.360' AS DateTime), N'system', N'system')
INSERT [dbo].[EntMenuItem] ([MenuItemId], [MenuItemName], [Description], [URL], [ParentMenuItemId], [DisplaySequence], [IsAlwaysEnabled], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (2, N'Security', NULL, NULL, 1, 1, 0, CAST(N'2023-07-19T04:02:00.360' AS DateTime), CAST(N'2023-07-19T04:02:00.360' AS DateTime), N'system', N'system')
INSERT [dbo].[EntMenuItem] ([MenuItemId], [MenuItemName], [Description], [URL], [ParentMenuItemId], [DisplaySequence], [IsAlwaysEnabled], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (3, N'Users', N'Manage the users who can access the system.', N'Administration/User.aspx', 2, 1, 0, CAST(N'2023-07-19T04:02:00.360' AS DateTime), CAST(N'2023-07-19T04:02:00.360' AS DateTime), N'system', N'system')
INSERT [dbo].[EntMenuItem] ([MenuItemId], [MenuItemName], [Description], [URL], [ParentMenuItemId], [DisplaySequence], [IsAlwaysEnabled], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (4, N'Roles', N'Manage the users who can access the system.', N'Administration/Role.aspx', 2, 2, 0, CAST(N'2023-07-19T04:02:00.360' AS DateTime), CAST(N'2023-07-19T04:02:00.360' AS DateTime), N'system', N'system')
INSERT [dbo].[EntMenuItem] ([MenuItemId], [MenuItemName], [Description], [URL], [ParentMenuItemId], [DisplaySequence], [IsAlwaysEnabled], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (5, N'Backup', N'To take database backup', N'DatabaseManagement/BackUP.aspx', 7, 1, 0, CAST(N'2023-07-19T04:02:00.360' AS DateTime), CAST(N'2023-07-19T04:02:00.360' AS DateTime), N'system', N'system')
INSERT [dbo].[EntMenuItem] ([MenuItemId], [MenuItemName], [Description], [URL], [ParentMenuItemId], [DisplaySequence], [IsAlwaysEnabled], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (6, N'Restore', N'To restore database', N'DatabaseManagement/Restore.aspx', 7, 2, 0, CAST(N'2023-07-19T04:02:00.360' AS DateTime), CAST(N'2023-07-19T04:02:00.360' AS DateTime), N'system', N'system')
INSERT [dbo].[EntMenuItem] ([MenuItemId], [MenuItemName], [Description], [URL], [ParentMenuItemId], [DisplaySequence], [IsAlwaysEnabled], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (7, N'Database', NULL, NULL, 1, 1, 0, CAST(N'2023-07-19T04:02:00.360' AS DateTime), CAST(N'2023-07-19T04:02:00.360' AS DateTime), N'system', N'system')
INSERT [dbo].[EntMenuItem] ([MenuItemId], [MenuItemName], [Description], [URL], [ParentMenuItemId], [DisplaySequence], [IsAlwaysEnabled], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (14, N'Salers', N'Salers', N'Basic/Salers.aspx', 8, 7, 0, CAST(N'2023-07-19T04:02:00.360' AS DateTime), CAST(N'2023-07-19T04:02:00.360' AS DateTime), N'system', N'system')
GO
SET IDENTITY_INSERT [dbo].[EntRole] ON 

INSERT [dbo].[EntRole] ([RoleId], [RoleName], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (1, N'Admin', CAST(N'2023-07-19T04:01:19.540' AS DateTime), CAST(N'2023-07-19T04:01:19.540' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRole] ([RoleId], [RoleName], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (2, N'Developer', CAST(N'2023-07-19T04:01:19.540' AS DateTime), CAST(N'2023-07-19T04:01:19.540' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRole] ([RoleId], [RoleName], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (9, N'Team Leader', CAST(N'2023-07-19T04:01:19.540' AS DateTime), CAST(N'2023-07-19T04:01:19.540' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRole] ([RoleId], [RoleName], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10, N'Merchant', CAST(N'2023-08-03T00:59:13.913' AS DateTime), CAST(N'2023-08-03T01:01:16.013' AS DateTime), N'alayu', N'alayu')
SET IDENTITY_INSERT [dbo].[EntRole] OFF
GO
SET IDENTITY_INSERT [dbo].[EntRoleCapability] ON 

INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (1, 1, 3, 1, CAST(N'2023-07-19T04:01:04.937' AS DateTime), CAST(N'2023-07-19T04:01:04.937' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (2, 1, 4, 1, CAST(N'2023-07-19T04:01:04.937' AS DateTime), CAST(N'2023-07-19T04:01:04.937' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (3, 1, 2, 2, CAST(N'2023-07-19T04:01:04.937' AS DateTime), CAST(N'2023-07-19T04:01:04.937' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (4, 1, 1, 3, CAST(N'2023-07-19T04:01:04.937' AS DateTime), CAST(N'2023-07-19T04:01:04.937' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (5, 1, 8, 3, CAST(N'2023-07-19T04:01:04.937' AS DateTime), CAST(N'2023-07-19T04:01:04.937' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (6, 1, 5, 3, CAST(N'2023-07-19T04:01:04.937' AS DateTime), CAST(N'2023-07-19T04:01:04.937' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (7, 1, 6, 3, CAST(N'2023-07-19T04:01:04.937' AS DateTime), CAST(N'2023-07-19T04:01:04.937' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (8, 1, 7, 3, CAST(N'2023-07-19T04:01:04.937' AS DateTime), CAST(N'2023-07-19T04:01:04.937' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (9, 1, 9, 3, CAST(N'2023-07-19T04:01:04.937' AS DateTime), CAST(N'2023-07-19T04:01:04.937' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10011, 1, 10, 3, CAST(N'2023-07-19T04:01:04.937' AS DateTime), CAST(N'2023-07-19T04:01:04.937' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10012, 10, 3, 0, CAST(N'2023-08-03T00:59:13.997' AS DateTime), CAST(N'2023-08-03T01:01:16.363' AS DateTime), N'alayu', N'alayu')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10013, 10, 4, 0, CAST(N'2023-08-03T00:59:14.003' AS DateTime), CAST(N'2023-08-03T01:01:16.403' AS DateTime), N'alayu', N'alayu')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10014, 10, 2, 0, CAST(N'2023-08-03T00:59:14.003' AS DateTime), CAST(N'2023-08-03T01:01:16.407' AS DateTime), N'alayu', N'alayu')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10015, 10, 1, 0, CAST(N'2023-08-03T00:59:14.003' AS DateTime), CAST(N'2023-08-03T01:01:16.407' AS DateTime), N'alayu', N'alayu')
INSERT [dbo].[EntRoleCapability] ([RoleCapabilityId], [RoleId], [CapabilityId], [AccessFlag], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10016, 10, 10, 2, CAST(N'2023-08-03T00:59:14.003' AS DateTime), CAST(N'2023-08-03T01:01:16.410' AS DateTime), N'alayu', N'alayu')
SET IDENTITY_INSERT [dbo].[EntRoleCapability] OFF
GO
SET IDENTITY_INSERT [dbo].[EntRoleUserAccount] ON 

INSERT [dbo].[EntRoleUserAccount] ([RoleUserAccountId], [RoleId], [UserAccountId], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (1, 1, 2, CAST(N'2023-07-19T04:00:51.727' AS DateTime), CAST(N'2023-07-19T04:00:51.727' AS DateTime), N'system', N'system')
INSERT [dbo].[EntRoleUserAccount] ([RoleUserAccountId], [RoleId], [UserAccountId], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (3, 10, 11, CAST(N'2023-08-03T01:01:16.683' AS DateTime), CAST(N'2023-08-03T01:01:16.683' AS DateTime), N'alayu', N'alayu')
INSERT [dbo].[EntRoleUserAccount] ([RoleUserAccountId], [RoleId], [UserAccountId], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10002, 10, 10012, CAST(N'2023-09-20T00:22:52.103' AS DateTime), CAST(N'2023-09-20T00:22:52.317' AS DateTime), N'alayu', N'alayu')
INSERT [dbo].[EntRoleUserAccount] ([RoleUserAccountId], [RoleId], [UserAccountId], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10003, 16, 10013, CAST(N'2023-09-20T00:29:32.583' AS DateTime), CAST(N'2023-09-20T00:29:32.583' AS DateTime), N'alayu', N'alayu')
INSERT [dbo].[EntRoleUserAccount] ([RoleUserAccountId], [RoleId], [UserAccountId], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10004, 10, 10014, CAST(N'2023-09-20T00:30:39.043' AS DateTime), CAST(N'2023-09-20T00:30:39.043' AS DateTime), N'alayu', N'alayu')
SET IDENTITY_INSERT [dbo].[EntRoleUserAccount] OFF
GO
SET IDENTITY_INSERT [dbo].[EntUserAccount] ON 

INSERT [dbo].[EntUserAccount] ([UserAccountId], [UserAccountName], [FirstName], [LastName], [Phone], [Shortcode], [Status], [UserPassword], [PWDChangeDate], [IsNewPassword], [IsLocked], [PAsswordAttemptNo], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (1, N'biruk', N'Biruk', N'Zegeju', N'0912124545', N'123456', 1, N'M1mbiRv4W/uzM9Y7wtGQYA==', CAST(N'2013-06-06T15:42:25.000' AS DateTime), 0, 0, 0, CAST(N'2023-07-19T04:00:24.020' AS DateTime), CAST(N'2023-07-19T04:00:24.020' AS DateTime), N'system', N'system')
INSERT [dbo].[EntUserAccount] ([UserAccountId], [UserAccountName], [FirstName], [LastName], [Phone], [Shortcode], [Status], [UserPassword], [PWDChangeDate], [IsNewPassword], [IsLocked], [PAsswordAttemptNo], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (2, N'alayu', N'Alayu', N'Demisew', N'0912124545', N'722300', 1, N'M1mbiRv4W/uzM9Y7wtGQYA==', CAST(N'2023-08-03T06:00:04.553' AS DateTime), 0, 0, 0, CAST(N'2023-07-19T04:00:24.020' AS DateTime), CAST(N'2023-08-03T06:00:04.557' AS DateTime), N'system', N'alayu')
INSERT [dbo].[EntUserAccount] ([UserAccountId], [UserAccountName], [FirstName], [LastName], [Phone], [Shortcode], [Status], [UserPassword], [PWDChangeDate], [IsNewPassword], [IsLocked], [PAsswordAttemptNo], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10, N'aa', N'aa', N'bb', N'aa', N'aa', 1, N'F3HaCmruLtnbGiYY/aYb5w==', CAST(N'2023-08-02T22:17:21.943' AS DateTime), 0, 0, 0, CAST(N'2023-08-02T22:17:08.173' AS DateTime), CAST(N'2023-08-02T22:17:21.970' AS DateTime), N'alayu', N'aa')
INSERT [dbo].[EntUserAccount] ([UserAccountId], [UserAccountName], [FirstName], [LastName], [Phone], [Shortcode], [Status], [UserPassword], [PWDChangeDate], [IsNewPassword], [IsLocked], [PAsswordAttemptNo], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (11, N'test', N'Abebe', N'Kebede', N'0944445555', N'123456', 1, N'rU+rMrASt8TNJ6bLoyaUwg==', CAST(N'2023-08-03T00:54:42.813' AS DateTime), 0, 0, 0, CAST(N'2023-08-03T00:53:28.073' AS DateTime), CAST(N'2023-08-03T00:54:42.817' AS DateTime), N'alayu', N'test')
INSERT [dbo].[EntUserAccount] ([UserAccountId], [UserAccountName], [FirstName], [LastName], [Phone], [Shortcode], [Status], [UserPassword], [PWDChangeDate], [IsNewPassword], [IsLocked], [PAsswordAttemptNo], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (12, N'w', N'w', N'w', N'w', N'w', 1, N'JN2/e5ps8usfDR/jAyKeIg==', CAST(N'2023-08-03T05:40:30.830' AS DateTime), 1, 0, 0, CAST(N'2023-08-03T05:40:30.830' AS DateTime), CAST(N'2023-08-03T05:40:30.830' AS DateTime), N'alayu', N'alayu')
INSERT [dbo].[EntUserAccount] ([UserAccountId], [UserAccountName], [FirstName], [LastName], [Phone], [Shortcode], [Status], [UserPassword], [PWDChangeDate], [IsNewPassword], [IsLocked], [PAsswordAttemptNo], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10012, N't', N't', N't', N't', N't', 1, N'M1mbiRv4W/uzM9Y7wtGQYA==', CAST(N'2023-09-20T00:23:18.630' AS DateTime), 0, 0, 0, CAST(N'2023-09-20T00:22:33.930' AS DateTime), CAST(N'2023-09-20T00:23:18.633' AS DateTime), N'alayu', N't')
INSERT [dbo].[EntUserAccount] ([UserAccountId], [UserAccountName], [FirstName], [LastName], [Phone], [Shortcode], [Status], [UserPassword], [PWDChangeDate], [IsNewPassword], [IsLocked], [PAsswordAttemptNo], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10013, N'q', N'q', N'q', N'q', N'q', 1, N'90YRPC6onrruc1n+DxZ9CQ==', CAST(N'2023-09-20T00:29:16.207' AS DateTime), 1, 0, 0, CAST(N'2023-09-20T00:29:16.207' AS DateTime), CAST(N'2023-09-20T00:29:16.207' AS DateTime), N'alayu', N'alayu')
INSERT [dbo].[EntUserAccount] ([UserAccountId], [UserAccountName], [FirstName], [LastName], [Phone], [Shortcode], [Status], [UserPassword], [PWDChangeDate], [IsNewPassword], [IsLocked], [PAsswordAttemptNo], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10014, N'p', N'p', N'p', N'p', N'p', 1, N'oFhOxBZFZkA3d3itioI72A==', CAST(N'2023-09-20T00:30:56.063' AS DateTime), 0, 0, 0, CAST(N'2023-09-20T00:30:29.820' AS DateTime), CAST(N'2023-09-20T00:30:56.067' AS DateTime), N'alayu', N'p')
SET IDENTITY_INSERT [dbo].[EntUserAccount] OFF
GO
SET IDENTITY_INSERT [dbo].[LogInOut] ON 

INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (280990, N'sb', CAST(N'2022-04-05T09:00:44.327' AS DateTime), CAST(N'2022-04-05T09:00:44.327' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (280991, N'sb', CAST(N'2022-04-05T09:09:53.317' AS DateTime), CAST(N'2022-04-05T09:09:53.317' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (280992, N'sb', CAST(N'2022-04-05T09:11:27.010' AS DateTime), CAST(N'2022-04-05T09:11:27.010' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (280993, N'a', CAST(N'2022-04-05T09:11:37.737' AS DateTime), CAST(N'2022-04-05T09:11:37.737' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (280994, N'sb', CAST(N'2022-04-05T09:12:21.387' AS DateTime), CAST(N'2022-04-05T09:12:21.387' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (280995, N'sb', CAST(N'2022-04-05T09:30:58.697' AS DateTime), CAST(N'2022-04-05T09:30:58.697' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (280996, N'sb', CAST(N'2022-04-05T09:36:33.807' AS DateTime), CAST(N'2022-04-05T09:36:33.807' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (280997, N'sb', CAST(N'2022-04-05T09:48:03.627' AS DateTime), CAST(N'2022-04-05T09:48:03.627' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (280998, N'sb', CAST(N'2022-04-05T09:50:02.377' AS DateTime), CAST(N'2022-04-05T09:50:02.377' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (280999, N'sb', CAST(N'2022-04-05T09:53:58.923' AS DateTime), CAST(N'2022-04-05T09:53:58.923' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281000, N'sb', CAST(N'2022-04-05T09:56:25.813' AS DateTime), CAST(N'2022-04-05T09:56:25.813' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281001, N'sb', CAST(N'2022-04-05T10:13:17.130' AS DateTime), CAST(N'2022-04-05T10:13:17.130' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281002, N'sb', CAST(N'2022-04-05T10:13:28.710' AS DateTime), CAST(N'2022-04-05T10:13:28.710' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281003, N'sb', CAST(N'2022-04-05T10:13:44.707' AS DateTime), CAST(N'2022-04-05T10:13:44.707' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281004, N'sb', CAST(N'2022-04-05T10:22:10.657' AS DateTime), CAST(N'2022-04-05T10:22:10.657' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281005, N'sb', CAST(N'2022-04-05T10:28:08.107' AS DateTime), CAST(N'2022-04-05T10:28:08.107' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281006, N'sb', CAST(N'2022-04-05T10:30:57.837' AS DateTime), CAST(N'2022-04-05T10:30:57.837' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281007, N'a', CAST(N'2022-04-05T10:32:15.993' AS DateTime), CAST(N'2022-04-05T10:32:15.993' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281008, N'sb', CAST(N'2022-04-05T10:32:49.917' AS DateTime), CAST(N'2022-04-05T10:32:49.917' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281009, N'a', CAST(N'2022-04-05T10:33:27.707' AS DateTime), CAST(N'2022-04-05T10:33:27.707' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281010, N'sb', CAST(N'2022-04-05T10:33:50.047' AS DateTime), CAST(N'2022-04-05T10:33:50.047' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281011, N'a', CAST(N'2022-04-05T10:35:26.333' AS DateTime), CAST(N'2022-04-05T10:35:26.333' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281012, N'sb', CAST(N'2022-04-05T10:47:52.153' AS DateTime), CAST(N'2022-04-05T10:47:52.153' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281013, N'sb', CAST(N'2022-04-05T11:06:17.373' AS DateTime), CAST(N'2022-04-05T11:06:17.373' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281014, N'sb', CAST(N'2022-04-05T11:10:09.670' AS DateTime), CAST(N'2022-04-05T11:10:09.670' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281015, N'a', CAST(N'2022-04-05T11:13:14.480' AS DateTime), CAST(N'2022-04-05T11:13:14.480' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281016, N'sb', CAST(N'2022-04-05T11:25:13.897' AS DateTime), CAST(N'2022-04-05T11:25:13.897' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281017, N'a', CAST(N'2022-04-05T11:26:14.300' AS DateTime), CAST(N'2022-04-05T11:26:14.300' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281018, N'Admin', CAST(N'2022-04-05T12:10:42.807' AS DateTime), CAST(N'2022-04-05T12:10:42.807' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281019, N'a', CAST(N'2022-04-05T12:12:40.687' AS DateTime), CAST(N'2022-04-05T12:12:40.687' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281020, N'Admin', CAST(N'2022-04-05T12:12:52.460' AS DateTime), CAST(N'2022-04-05T12:12:52.460' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281021, N'Admin', CAST(N'2022-04-05T12:16:00.790' AS DateTime), CAST(N'2022-04-05T12:16:00.790' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281022, N'Admin', CAST(N'2022-04-05T12:16:06.943' AS DateTime), CAST(N'2022-04-05T12:16:06.943' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281023, N'Admin', CAST(N'2022-04-05T12:17:10.650' AS DateTime), CAST(N'2022-04-05T12:17:10.650' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281024, N'Admin', CAST(N'2022-04-05T12:24:29.713' AS DateTime), CAST(N'2022-04-05T12:24:29.713' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281025, N'Admin', CAST(N'2022-04-05T12:35:01.673' AS DateTime), CAST(N'2022-04-05T12:35:01.673' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281026, N'Admin', CAST(N'2022-04-05T12:49:46.037' AS DateTime), CAST(N'2022-04-05T12:49:46.037' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281027, N'a', CAST(N'2022-04-05T12:51:08.287' AS DateTime), CAST(N'2022-04-05T12:51:08.287' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281028, N'a', CAST(N'2022-04-05T12:51:42.700' AS DateTime), CAST(N'2022-04-05T12:51:42.700' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281029, N'Admin', CAST(N'2022-04-05T12:55:04.850' AS DateTime), CAST(N'2022-04-05T12:55:04.850' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281030, N'User', CAST(N'2022-04-05T12:55:16.853' AS DateTime), CAST(N'2022-04-05T12:55:16.853' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281031, N'Admin', CAST(N'2022-04-05T12:58:25.133' AS DateTime), CAST(N'2022-04-05T12:58:25.133' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281032, N'Admin', CAST(N'2022-04-05T12:59:25.297' AS DateTime), CAST(N'2022-04-05T12:59:25.297' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281033, N'User', CAST(N'2022-04-05T13:00:56.863' AS DateTime), CAST(N'2022-04-05T13:00:56.863' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281034, N'Admin', CAST(N'2022-04-05T13:20:44.483' AS DateTime), CAST(N'2022-04-05T13:20:44.483' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281035, N'Admin', CAST(N'2022-04-07T07:44:39.250' AS DateTime), CAST(N'2022-04-07T07:44:39.250' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281036, N'Admin', CAST(N'2022-04-07T09:01:27.720' AS DateTime), CAST(N'2022-04-07T09:01:27.720' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281037, N'Admin', CAST(N'2022-04-07T09:25:06.840' AS DateTime), CAST(N'2022-04-07T09:25:06.840' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281038, N'Admin', CAST(N'2022-04-07T09:51:12.607' AS DateTime), CAST(N'2022-04-07T09:51:12.607' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281039, N'Admin', CAST(N'2022-04-07T09:56:33.097' AS DateTime), CAST(N'2022-04-07T09:56:33.097' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281040, N'Admin', CAST(N'2022-04-07T10:08:37.157' AS DateTime), CAST(N'2022-04-07T10:08:37.157' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281041, N'Admin', CAST(N'2022-04-07T10:35:20.340' AS DateTime), CAST(N'2022-04-07T10:35:20.340' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281042, N'Admin', CAST(N'2022-04-07T11:02:11.820' AS DateTime), CAST(N'2022-04-07T11:02:11.820' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281043, N'Admin', CAST(N'2022-04-07T11:46:08.537' AS DateTime), CAST(N'2022-04-07T11:46:08.537' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281044, N'Admin', CAST(N'2022-04-07T12:03:28.700' AS DateTime), CAST(N'2022-04-07T12:03:28.700' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281045, N'Admin', CAST(N'2022-04-07T14:17:03.953' AS DateTime), CAST(N'2022-04-07T14:17:03.953' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281046, N'Admin', CAST(N'2022-04-07T14:29:59.810' AS DateTime), CAST(N'2022-04-07T14:29:59.810' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281047, N'Admin', CAST(N'2022-04-07T15:07:33.847' AS DateTime), CAST(N'2022-04-07T15:07:33.847' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281048, N'Admin', CAST(N'2022-04-07T15:45:48.740' AS DateTime), CAST(N'2022-04-07T15:45:48.740' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281049, N'Admin', CAST(N'2022-04-07T15:48:15.970' AS DateTime), CAST(N'2022-04-07T15:48:15.970' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281050, N'Admin', CAST(N'2022-04-07T16:00:31.907' AS DateTime), CAST(N'2022-04-07T16:00:31.907' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281051, N'Admin', CAST(N'2022-04-07T16:53:05.537' AS DateTime), CAST(N'2022-04-07T16:53:05.537' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281052, N'Admin', CAST(N'2022-04-07T16:57:23.400' AS DateTime), CAST(N'2022-04-07T16:57:23.400' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281053, N'Admin', CAST(N'2022-04-07T17:01:28.910' AS DateTime), CAST(N'2022-04-07T17:01:28.910' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281054, N'Admin', CAST(N'2022-04-07T17:15:36.453' AS DateTime), CAST(N'2022-04-07T17:15:36.453' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281055, N'Admin', CAST(N'2022-04-07T17:22:10.923' AS DateTime), CAST(N'2022-04-07T17:22:10.923' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281056, N'Admin', CAST(N'2022-04-08T07:46:30.120' AS DateTime), CAST(N'2022-04-08T07:46:30.120' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281057, N'Admin', CAST(N'2022-04-08T08:07:00.343' AS DateTime), CAST(N'2022-04-08T08:07:00.343' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281058, N'Admin', CAST(N'2022-04-08T08:31:02.050' AS DateTime), CAST(N'2022-04-08T08:31:02.050' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281059, N'Admin', CAST(N'2022-04-08T09:07:58.173' AS DateTime), CAST(N'2022-04-08T09:07:58.173' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281060, N'Admin', CAST(N'2022-04-08T09:16:09.757' AS DateTime), CAST(N'2022-04-08T09:16:09.757' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281061, N'Admin', CAST(N'2022-04-08T09:18:37.553' AS DateTime), CAST(N'2022-04-08T09:18:37.553' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281062, N'Admin', CAST(N'2022-04-08T09:19:33.093' AS DateTime), CAST(N'2022-04-08T09:19:33.093' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281063, N'Admin', CAST(N'2022-04-08T10:16:41.270' AS DateTime), CAST(N'2022-04-08T10:16:41.270' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281064, N'Admin', CAST(N'2022-04-08T11:08:22.607' AS DateTime), CAST(N'2022-04-08T11:08:22.607' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281065, N'Admin', CAST(N'2022-04-08T11:12:18.197' AS DateTime), CAST(N'2022-04-08T11:12:18.197' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281066, N'Admin', CAST(N'2022-04-08T13:57:10.113' AS DateTime), CAST(N'2022-04-08T13:57:10.113' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281067, N'Admin', CAST(N'2022-04-08T14:30:47.360' AS DateTime), CAST(N'2022-04-08T14:30:47.360' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281068, N'Admin', CAST(N'2022-04-08T15:39:06.257' AS DateTime), CAST(N'2022-04-08T15:39:06.257' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281069, N'Admin', CAST(N'2022-04-08T16:03:15.907' AS DateTime), CAST(N'2022-04-08T16:03:15.907' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281070, N'Admin', CAST(N'2022-04-09T08:45:45.020' AS DateTime), CAST(N'2022-04-09T08:45:45.020' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281071, N'Admin', CAST(N'2022-04-09T09:32:03.970' AS DateTime), CAST(N'2022-04-09T09:32:03.970' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281072, N'Admin', CAST(N'2022-04-09T09:46:02.697' AS DateTime), CAST(N'2022-04-09T09:46:02.697' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281073, N'Admin', CAST(N'2022-04-09T10:01:38.080' AS DateTime), CAST(N'2022-04-09T10:01:38.080' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281074, N'Admin', CAST(N'2022-04-09T10:27:34.967' AS DateTime), CAST(N'2022-04-09T10:27:34.967' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281075, N'Admin', CAST(N'2022-04-09T11:53:28.447' AS DateTime), CAST(N'2022-04-09T11:53:28.447' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281076, N'Admin', CAST(N'2022-04-09T11:56:43.930' AS DateTime), CAST(N'2022-04-09T11:56:43.930' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (281077, N'Admin', CAST(N'2022-04-09T12:06:14.440' AS DateTime), CAST(N'2022-04-09T12:06:14.440' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291070, N'Admin', CAST(N'2022-04-11T08:18:30.763' AS DateTime), CAST(N'2022-04-11T08:18:30.763' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291071, N'Admin', CAST(N'2022-04-11T08:59:53.173' AS DateTime), CAST(N'2022-04-11T08:59:53.173' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291072, N'Admin', CAST(N'2022-04-11T09:36:17.280' AS DateTime), CAST(N'2022-04-11T09:36:17.280' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291073, N'Admin', CAST(N'2022-04-11T09:57:46.583' AS DateTime), CAST(N'2022-04-11T09:57:46.583' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291074, N'Admin', CAST(N'2022-04-11T10:54:13.643' AS DateTime), CAST(N'2022-04-11T10:54:13.643' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291075, N'Admin', CAST(N'2022-04-11T11:33:32.930' AS DateTime), CAST(N'2022-04-11T11:33:32.930' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291076, N'Admin', CAST(N'2022-04-11T12:08:31.020' AS DateTime), CAST(N'2022-04-11T12:08:31.020' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291077, N'Admin', CAST(N'2022-04-11T13:26:56.333' AS DateTime), CAST(N'2022-04-11T13:26:56.333' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291078, N'Admin', CAST(N'2022-04-11T14:19:24.807' AS DateTime), CAST(N'2022-04-11T14:19:24.807' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291079, N'Admin', CAST(N'2022-04-11T15:02:17.943' AS DateTime), CAST(N'2022-04-11T15:02:17.943' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291080, N'Admin', CAST(N'2022-04-11T15:55:10.850' AS DateTime), CAST(N'2022-04-11T15:55:10.850' AS DateTime), N'I', N'DESKTOP-1N13BGF')
GO
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291081, N'Admin', CAST(N'2022-04-11T16:14:49.840' AS DateTime), CAST(N'2022-04-11T16:14:49.840' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291082, N'Admin', CAST(N'2022-04-12T08:11:27.650' AS DateTime), CAST(N'2022-04-12T08:11:27.650' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291083, N'Admin', CAST(N'2022-04-12T08:19:28.203' AS DateTime), CAST(N'2022-04-12T08:19:28.203' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291084, N'Admin', CAST(N'2022-04-12T09:03:55.087' AS DateTime), CAST(N'2022-04-12T09:03:55.087' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291085, N'Admin', CAST(N'2022-04-12T09:58:25.143' AS DateTime), CAST(N'2022-04-12T09:58:25.143' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291086, N'Admin', CAST(N'2022-04-12T09:59:16.727' AS DateTime), CAST(N'2022-04-12T09:59:16.727' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291087, N'Admin', CAST(N'2022-04-12T10:08:03.070' AS DateTime), CAST(N'2022-04-12T10:08:03.070' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291088, N'Admin', CAST(N'2022-04-12T10:33:09.493' AS DateTime), CAST(N'2022-04-12T10:33:09.493' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (291089, N'Admin', CAST(N'2022-04-12T10:45:44.373' AS DateTime), CAST(N'2022-04-12T10:45:44.373' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (301082, N'Admin', CAST(N'2022-04-12T11:13:05.330' AS DateTime), CAST(N'2022-04-12T11:13:05.330' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (301083, N'Admin', CAST(N'2022-04-12T11:17:13.417' AS DateTime), CAST(N'2022-04-12T11:17:13.417' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (301084, N'Admin', CAST(N'2022-04-12T11:25:29.683' AS DateTime), CAST(N'2022-04-12T11:25:29.683' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (301085, N'Admin', CAST(N'2022-04-12T11:49:34.903' AS DateTime), CAST(N'2022-04-12T11:49:34.903' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311082, N'Admin', CAST(N'2022-04-12T12:23:30.003' AS DateTime), CAST(N'2022-04-12T12:23:30.003' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311083, N'Admin', CAST(N'2022-04-12T12:23:31.657' AS DateTime), CAST(N'2022-04-12T12:23:31.657' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311084, N'Admin', CAST(N'2022-04-12T13:52:05.380' AS DateTime), CAST(N'2022-04-12T13:52:05.380' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311085, N'Admin', CAST(N'2022-04-12T14:14:09.527' AS DateTime), CAST(N'2022-04-12T14:14:09.527' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311086, N'Admin', CAST(N'2022-04-12T15:10:56.577' AS DateTime), CAST(N'2022-04-12T15:10:56.577' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311087, N'Admin', CAST(N'2022-04-12T15:27:24.407' AS DateTime), CAST(N'2022-04-12T15:27:24.407' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311088, N'Admin', CAST(N'2022-04-12T16:01:51.653' AS DateTime), CAST(N'2022-04-12T16:01:51.653' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311089, N'Admin', CAST(N'2022-04-12T16:31:32.987' AS DateTime), CAST(N'2022-04-12T16:31:32.987' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311090, N'Admin', CAST(N'2022-04-12T16:53:04.067' AS DateTime), CAST(N'2022-04-12T16:53:04.067' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311091, N'Admin', CAST(N'2022-04-12T16:58:11.907' AS DateTime), CAST(N'2022-04-12T16:58:11.907' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311092, N'Admin', CAST(N'2022-04-13T08:05:52.360' AS DateTime), CAST(N'2022-04-13T08:05:52.360' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311093, N'Admin', CAST(N'2022-04-13T09:17:30.547' AS DateTime), CAST(N'2022-04-13T09:17:30.547' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311094, N'Admin', CAST(N'2022-04-13T09:36:13.803' AS DateTime), CAST(N'2022-04-13T09:36:13.803' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311095, N'Admin', CAST(N'2022-04-13T09:52:57.867' AS DateTime), CAST(N'2022-04-13T09:52:57.867' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311096, N'Admin', CAST(N'2022-04-13T10:00:43.050' AS DateTime), CAST(N'2022-04-13T10:00:43.050' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311097, N'Admin', CAST(N'2022-04-13T10:22:21.620' AS DateTime), CAST(N'2022-04-13T10:22:21.620' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311098, N'Admin', CAST(N'2022-04-13T10:49:55.110' AS DateTime), CAST(N'2022-04-13T10:49:55.110' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311099, N'Admin', CAST(N'2022-04-13T10:55:35.143' AS DateTime), CAST(N'2022-04-13T10:55:35.143' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311100, N'Admin', CAST(N'2022-04-13T10:57:09.330' AS DateTime), CAST(N'2022-04-13T10:57:09.330' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311101, N'Admin', CAST(N'2022-04-13T11:03:36.990' AS DateTime), CAST(N'2022-04-13T11:03:36.990' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311102, N'Admin', CAST(N'2022-04-13T11:07:34.527' AS DateTime), CAST(N'2022-04-13T11:07:34.527' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311103, N'Admin', CAST(N'2022-04-13T11:08:47.937' AS DateTime), CAST(N'2022-04-13T11:08:47.937' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311104, N'Admin', CAST(N'2022-04-13T11:13:26.477' AS DateTime), CAST(N'2022-04-13T11:13:26.477' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311105, N'Admin', CAST(N'2022-04-13T11:19:34.400' AS DateTime), CAST(N'2022-04-13T11:19:34.400' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311106, N'Admin', CAST(N'2022-04-13T11:37:14.757' AS DateTime), CAST(N'2022-04-13T11:37:14.757' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311107, N'Admin', CAST(N'2022-04-13T12:00:15.300' AS DateTime), CAST(N'2022-04-13T12:00:15.300' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311108, N'Admin', CAST(N'2022-04-13T12:21:24.500' AS DateTime), CAST(N'2022-04-13T12:21:24.500' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311109, N'Admin', CAST(N'2022-04-13T12:24:12.360' AS DateTime), CAST(N'2022-04-13T12:24:12.360' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311110, N'Admin', CAST(N'2022-04-13T12:37:53.020' AS DateTime), CAST(N'2022-04-13T12:37:53.020' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311111, N'Admin', CAST(N'2022-04-13T12:39:09.650' AS DateTime), CAST(N'2022-04-13T12:39:09.650' AS DateTime), N'I', N'ISCST-APP-S52.cbe.com.et')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311112, N'Admin', CAST(N'2022-04-13T13:03:50.263' AS DateTime), CAST(N'2022-04-13T13:03:50.263' AS DateTime), N'I', N'ISCST-APP-S52.cbe.com.et')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311113, N'Admin', CAST(N'2022-04-13T14:02:21.013' AS DateTime), CAST(N'2022-04-13T14:02:21.013' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311114, N'Admin', CAST(N'2022-04-13T14:09:19.463' AS DateTime), CAST(N'2022-04-13T14:09:19.463' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311115, N'Admin', CAST(N'2022-04-13T14:09:39.373' AS DateTime), CAST(N'2022-04-13T14:09:39.373' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311116, N'Admin', CAST(N'2022-04-13T14:12:55.400' AS DateTime), CAST(N'2022-04-13T14:12:55.400' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (311117, N'Admin', CAST(N'2022-04-13T14:23:29.687' AS DateTime), CAST(N'2022-04-13T14:23:29.687' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (321092, N'Admin', CAST(N'2022-04-13T15:18:44.370' AS DateTime), CAST(N'2022-04-13T15:18:44.370' AS DateTime), N'I', N'ISCST-APP-S52.cbe.com.et')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (321093, N'Admin', CAST(N'2022-04-13T15:27:57.040' AS DateTime), CAST(N'2022-04-13T15:27:57.040' AS DateTime), N'I', N'DESKTOP-SNOHG3P.local')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (321094, N'Admin', CAST(N'2022-04-13T15:47:36.933' AS DateTime), CAST(N'2022-04-13T15:47:36.933' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (321095, N'Admin', CAST(N'2022-04-13T16:17:36.737' AS DateTime), CAST(N'2022-04-13T16:17:36.737' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (321096, N'Admin', CAST(N'2022-04-13T16:22:20.650' AS DateTime), CAST(N'2022-04-13T16:22:20.650' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (321097, N'Admin', CAST(N'2022-04-13T16:25:28.637' AS DateTime), CAST(N'2022-04-13T16:25:28.637' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (321098, N'Admin', CAST(N'2022-04-13T16:35:07.377' AS DateTime), CAST(N'2022-04-13T16:35:07.377' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (321099, N'Admin', CAST(N'2022-04-13T16:38:38.770' AS DateTime), CAST(N'2022-04-13T16:38:38.770' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (321100, N'Admin', CAST(N'2022-04-13T16:56:05.957' AS DateTime), CAST(N'2022-04-13T16:56:05.957' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (321101, N'Admin', CAST(N'2022-04-13T17:03:11.897' AS DateTime), CAST(N'2022-04-13T17:03:11.897' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (321102, N'Admin', CAST(N'2022-04-13T17:17:43.333' AS DateTime), CAST(N'2022-04-13T17:17:43.333' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (321103, N'Admin', CAST(N'2022-04-13T17:23:35.417' AS DateTime), CAST(N'2022-04-13T17:23:35.417' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331102, N'Admin', CAST(N'2022-04-14T15:12:27.043' AS DateTime), CAST(N'2022-04-14T15:12:27.043' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331103, N'Admin', CAST(N'2022-04-14T15:17:50.473' AS DateTime), CAST(N'2022-04-14T15:17:50.473' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331104, N'Admin', CAST(N'2022-04-14T15:18:51.527' AS DateTime), CAST(N'2022-04-14T15:18:51.527' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331105, N'Admin', CAST(N'2022-04-14T15:20:55.903' AS DateTime), CAST(N'2022-04-14T15:20:55.903' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331106, N'Admin', CAST(N'2022-04-14T15:24:40.833' AS DateTime), CAST(N'2022-04-14T15:24:40.833' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331107, N'Admin', CAST(N'2022-04-14T15:25:20.650' AS DateTime), CAST(N'2022-04-14T15:25:20.650' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331108, N'Admin', CAST(N'2022-04-14T15:28:25.783' AS DateTime), CAST(N'2022-04-14T15:28:25.783' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331109, N'Admin', CAST(N'2022-04-14T15:31:04.207' AS DateTime), CAST(N'2022-04-14T15:31:04.207' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331110, N'Admin', CAST(N'2022-04-14T16:15:12.257' AS DateTime), CAST(N'2022-04-14T16:15:12.257' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331111, N'Admin', CAST(N'2022-04-14T16:43:03.913' AS DateTime), CAST(N'2022-04-14T16:43:03.913' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331112, N'Admin', CAST(N'2022-04-14T17:06:56.510' AS DateTime), CAST(N'2022-04-14T17:06:56.513' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331113, N'Admin', CAST(N'2022-04-15T08:30:17.777' AS DateTime), CAST(N'2022-04-15T08:30:17.777' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331114, N'Admin', CAST(N'2022-04-15T10:43:05.017' AS DateTime), CAST(N'2022-04-15T10:43:05.017' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331115, N'Admin', CAST(N'2022-04-15T10:51:21.637' AS DateTime), CAST(N'2022-04-15T10:51:21.637' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331116, N'Admin', CAST(N'2022-04-15T10:54:25.867' AS DateTime), CAST(N'2022-04-15T10:54:25.867' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331117, N'Admin', CAST(N'2022-04-15T10:54:46.090' AS DateTime), CAST(N'2022-04-15T10:54:46.090' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331118, N'Admin', CAST(N'2022-04-15T10:58:50.470' AS DateTime), CAST(N'2022-04-15T10:58:50.470' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (331119, N'Admin', CAST(N'2022-04-15T11:01:12.977' AS DateTime), CAST(N'2022-04-15T11:01:12.977' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (341113, N'Admin', CAST(N'2022-04-15T11:20:17.303' AS DateTime), CAST(N'2022-04-15T11:20:17.303' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (341114, N'Admin', CAST(N'2022-04-15T11:27:25.863' AS DateTime), CAST(N'2022-04-15T11:27:25.863' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351113, N'Admin', CAST(N'2022-04-16T08:49:50.100' AS DateTime), CAST(N'2022-04-16T08:49:50.100' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351114, N'Admin', CAST(N'2022-04-16T08:54:34.403' AS DateTime), CAST(N'2022-04-16T08:54:34.403' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351115, N'Admin', CAST(N'2022-04-16T08:59:14.803' AS DateTime), CAST(N'2022-04-16T08:59:14.803' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351116, N'Admin', CAST(N'2022-04-16T09:46:17.830' AS DateTime), CAST(N'2022-04-16T09:46:17.830' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351117, N'Admin', CAST(N'2022-04-16T10:11:41.787' AS DateTime), CAST(N'2022-04-16T10:11:41.790' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351118, N'Admin', CAST(N'2022-04-16T10:20:45.457' AS DateTime), CAST(N'2022-04-16T10:20:45.457' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351119, N'Admin', CAST(N'2022-04-16T11:01:37.760' AS DateTime), CAST(N'2022-04-16T11:01:37.760' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351120, N'Admin', CAST(N'2022-04-16T11:26:28.437' AS DateTime), CAST(N'2022-04-16T11:26:28.437' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351121, N'Admin', CAST(N'2022-04-16T11:54:17.933' AS DateTime), CAST(N'2022-04-16T11:54:17.933' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351122, N'Admin', CAST(N'2022-04-16T12:05:11.093' AS DateTime), CAST(N'2022-04-16T12:05:11.093' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351123, N'Admin', CAST(N'2022-04-18T08:15:40.200' AS DateTime), CAST(N'2022-04-18T08:15:40.200' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351124, N'Admin', CAST(N'2022-04-18T08:32:08.387' AS DateTime), CAST(N'2022-04-18T08:32:08.387' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351125, N'Admin', CAST(N'2022-04-18T08:34:16.090' AS DateTime), CAST(N'2022-04-18T08:34:16.090' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351126, N'Admin', CAST(N'2022-04-18T08:42:39.040' AS DateTime), CAST(N'2022-04-18T08:42:39.040' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351127, N'Admin', CAST(N'2022-04-18T08:57:23.457' AS DateTime), CAST(N'2022-04-18T08:57:23.457' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351128, N'Admin', CAST(N'2022-04-18T09:17:02.150' AS DateTime), CAST(N'2022-04-18T09:17:02.150' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351129, N'Admin', CAST(N'2022-04-18T09:17:35.297' AS DateTime), CAST(N'2022-04-18T09:17:35.297' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351130, N'Admin', CAST(N'2022-04-18T09:34:09.483' AS DateTime), CAST(N'2022-04-18T09:34:09.483' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351131, N'Admin', CAST(N'2022-04-18T10:04:29.593' AS DateTime), CAST(N'2022-04-18T10:04:29.593' AS DateTime), N'I', N'DESKTOP-1N13BGF')
GO
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351132, N'Admin', CAST(N'2022-04-18T10:37:49.727' AS DateTime), CAST(N'2022-04-18T10:37:49.727' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351133, N'Admin', CAST(N'2022-04-18T11:18:22.617' AS DateTime), CAST(N'2022-04-18T11:18:22.617' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351134, N'Admin', CAST(N'2022-04-18T11:33:38.917' AS DateTime), CAST(N'2022-04-18T11:33:38.920' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351135, N'Admin', CAST(N'2022-04-18T12:20:08.977' AS DateTime), CAST(N'2022-04-18T12:20:08.977' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351136, N'Admin', CAST(N'2022-04-18T12:59:21.153' AS DateTime), CAST(N'2022-04-18T12:59:21.153' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351137, N'Admin', CAST(N'2022-04-18T13:11:00.677' AS DateTime), CAST(N'2022-04-18T13:11:00.677' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351138, N'Admin', CAST(N'2022-04-18T13:17:09.707' AS DateTime), CAST(N'2022-04-18T13:17:09.707' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351139, N'Admin', CAST(N'2022-04-18T13:48:10.800' AS DateTime), CAST(N'2022-04-18T13:48:10.800' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351140, N'Admin', CAST(N'2022-04-18T13:56:48.453' AS DateTime), CAST(N'2022-04-18T13:56:48.453' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351141, N'Admin', CAST(N'2022-04-18T14:24:02.663' AS DateTime), CAST(N'2022-04-18T14:24:02.663' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351142, N'Admin', CAST(N'2022-04-18T14:24:04.130' AS DateTime), CAST(N'2022-04-18T14:24:04.130' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351143, N'Admin', CAST(N'2022-04-18T14:36:10.957' AS DateTime), CAST(N'2022-04-18T14:36:10.957' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351144, N'Admin', CAST(N'2022-04-18T14:51:22.563' AS DateTime), CAST(N'2022-04-18T14:51:22.563' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351145, N'Admin', CAST(N'2022-04-18T15:11:33.603' AS DateTime), CAST(N'2022-04-18T15:11:33.603' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351146, N'Admin', CAST(N'2022-04-18T15:56:13.810' AS DateTime), CAST(N'2022-04-18T15:56:13.810' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351147, N'Admin', CAST(N'2022-04-18T16:17:04.830' AS DateTime), CAST(N'2022-04-18T16:17:04.830' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351148, N'Admin', CAST(N'2022-05-03T10:09:19.433' AS DateTime), CAST(N'2022-05-03T10:09:19.433' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351149, N'Admin', CAST(N'2022-05-03T10:09:36.577' AS DateTime), CAST(N'2022-05-03T10:09:36.577' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351150, N'Admin', CAST(N'2022-05-03T10:44:13.447' AS DateTime), CAST(N'2022-05-03T10:44:13.447' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (351151, N'Admin', CAST(N'2022-05-03T11:30:11.603' AS DateTime), CAST(N'2022-05-03T11:30:11.603' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (361148, N'Admin', CAST(N'2022-05-03T11:55:29.543' AS DateTime), CAST(N'2022-05-03T11:55:29.543' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (361149, N'Admin', CAST(N'2022-05-03T12:44:53.447' AS DateTime), CAST(N'2022-05-03T12:44:53.447' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (361150, N'Admin', CAST(N'2022-05-03T13:12:32.677' AS DateTime), CAST(N'2022-05-03T13:12:32.677' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (361151, N'Admin', CAST(N'2022-05-03T13:18:19.400' AS DateTime), CAST(N'2022-05-03T13:18:19.400' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (361152, N'Admin', CAST(N'2022-05-03T13:21:26.050' AS DateTime), CAST(N'2022-05-03T13:21:26.050' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (361153, N'Admin', CAST(N'2022-05-03T13:22:12.013' AS DateTime), CAST(N'2022-05-03T13:22:12.013' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (361154, N'Admin', CAST(N'2022-05-03T13:22:17.210' AS DateTime), CAST(N'2022-05-03T13:22:17.210' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (361155, N'Admin', CAST(N'2022-05-03T13:22:33.560' AS DateTime), CAST(N'2022-05-03T13:22:33.560' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (361156, N'Admin', CAST(N'2022-05-03T13:23:35.877' AS DateTime), CAST(N'2022-05-03T13:23:35.877' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (361157, N'Admin', CAST(N'2022-05-03T13:27:11.100' AS DateTime), CAST(N'2022-05-03T13:27:11.100' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (361158, N'Admin', CAST(N'2022-05-03T13:42:22.857' AS DateTime), CAST(N'2022-05-03T13:42:22.857' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (361159, N'Admin', CAST(N'2022-05-03T13:55:49.053' AS DateTime), CAST(N'2022-05-03T13:55:49.053' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (371148, N'Admin', CAST(N'2022-05-03T14:21:33.140' AS DateTime), CAST(N'2022-05-03T14:21:33.140' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (371149, N'Admin', CAST(N'2022-05-03T14:46:28.613' AS DateTime), CAST(N'2022-05-03T14:46:28.613' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (381148, N'Admin', CAST(N'2022-05-03T15:07:31.513' AS DateTime), CAST(N'2022-05-03T15:07:31.517' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (381149, N'Admin', CAST(N'2022-05-03T15:51:03.513' AS DateTime), CAST(N'2022-05-03T15:51:03.513' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (381150, N'Admin', CAST(N'2022-05-03T16:20:59.687' AS DateTime), CAST(N'2022-05-03T16:20:59.687' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (381151, N'Admin', CAST(N'2022-05-03T16:34:56.043' AS DateTime), CAST(N'2022-05-03T16:34:56.043' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (381152, N'Admin', CAST(N'2022-05-03T16:50:27.513' AS DateTime), CAST(N'2022-05-03T16:50:27.513' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (381153, N'Admin', CAST(N'2022-05-04T09:03:01.403' AS DateTime), CAST(N'2022-05-04T09:03:01.403' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (391148, N'Admin', CAST(N'2022-05-04T09:32:51.617' AS DateTime), CAST(N'2022-05-04T09:32:51.617' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (391149, N'Admin', CAST(N'2022-05-04T09:36:13.503' AS DateTime), CAST(N'2022-05-04T09:36:13.503' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (391150, N'Admin', CAST(N'2022-05-04T09:36:35.707' AS DateTime), CAST(N'2022-05-04T09:36:35.707' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (391151, N'Admin', CAST(N'2022-05-04T09:41:54.663' AS DateTime), CAST(N'2022-05-04T09:41:54.663' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (391152, N'Admin', CAST(N'2022-05-04T10:08:29.920' AS DateTime), CAST(N'2022-05-04T10:08:29.920' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (391153, N'Admin', CAST(N'2022-05-04T10:26:54.220' AS DateTime), CAST(N'2022-05-04T10:26:54.220' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (401148, N'Admin', CAST(N'2022-05-04T11:05:23.050' AS DateTime), CAST(N'2022-05-04T11:05:23.050' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (411148, N'Admin', CAST(N'2022-05-04T11:27:54.523' AS DateTime), CAST(N'2022-05-04T11:27:54.523' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (411149, N'Admin', CAST(N'2022-05-04T11:35:47.797' AS DateTime), CAST(N'2022-05-04T11:35:47.797' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (411150, N'Admin', CAST(N'2022-05-04T11:48:57.910' AS DateTime), CAST(N'2022-05-04T11:48:57.910' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (411151, N'Admin', CAST(N'2022-05-04T12:04:12.687' AS DateTime), CAST(N'2022-05-04T12:04:12.687' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (411152, N'Admin', CAST(N'2022-05-04T12:10:47.500' AS DateTime), CAST(N'2022-05-04T12:10:47.500' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (411153, N'Admin', CAST(N'2022-05-04T12:22:12.063' AS DateTime), CAST(N'2022-05-04T12:22:12.063' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (411154, N'Admin', CAST(N'2022-05-04T13:28:03.900' AS DateTime), CAST(N'2022-05-04T13:28:03.900' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (411155, N'Admin', CAST(N'2022-05-04T14:01:02.833' AS DateTime), CAST(N'2022-05-04T14:01:02.833' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (411156, N'Admin', CAST(N'2022-05-04T14:38:08.833' AS DateTime), CAST(N'2022-05-04T14:38:08.833' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (411157, N'Admin', CAST(N'2022-05-04T14:39:29.233' AS DateTime), CAST(N'2022-05-04T14:39:29.233' AS DateTime), N'I', N'ISCST-APP-S52.cbe.com.et')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (411158, N'Admin', CAST(N'2022-05-04T14:47:29.317' AS DateTime), CAST(N'2022-05-04T14:47:29.317' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (411159, N'Admin', CAST(N'2022-05-04T15:00:58.460' AS DateTime), CAST(N'2022-05-04T15:00:58.460' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421148, N'Admin', CAST(N'2022-05-10T09:26:37.663' AS DateTime), CAST(N'2022-05-10T09:26:37.663' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421149, N'Admin', CAST(N'2022-05-10T09:49:46.990' AS DateTime), CAST(N'2022-05-10T09:49:46.990' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421150, N'Admin', CAST(N'2022-05-10T09:51:19.183' AS DateTime), CAST(N'2022-05-10T09:51:19.183' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421151, N'Admin', CAST(N'2022-05-10T09:57:28.790' AS DateTime), CAST(N'2022-05-10T09:57:28.790' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421152, N'Admin', CAST(N'2022-05-10T09:58:48.657' AS DateTime), CAST(N'2022-05-10T09:58:48.657' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421153, N'Admin', CAST(N'2022-05-10T10:01:13.033' AS DateTime), CAST(N'2022-05-10T10:01:13.033' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421154, N'Admin', CAST(N'2022-05-10T10:04:46.913' AS DateTime), CAST(N'2022-05-10T10:04:46.913' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421155, N'Admin', CAST(N'2022-05-10T10:20:27.063' AS DateTime), CAST(N'2022-05-10T10:20:27.063' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421156, N'Admin', CAST(N'2022-05-10T10:31:32.757' AS DateTime), CAST(N'2022-05-10T10:31:32.757' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421157, N'Admin', CAST(N'2022-05-10T10:33:54.877' AS DateTime), CAST(N'2022-05-10T10:33:54.877' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421158, N'Admin', CAST(N'2022-05-10T10:37:47.103' AS DateTime), CAST(N'2022-05-10T10:37:47.103' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421159, N'Admin', CAST(N'2022-05-10T10:39:48.380' AS DateTime), CAST(N'2022-05-10T10:39:48.380' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421160, N'Admin', CAST(N'2022-05-10T10:42:05.337' AS DateTime), CAST(N'2022-05-10T10:42:05.337' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421161, N'Admin', CAST(N'2022-05-10T10:44:32.900' AS DateTime), CAST(N'2022-05-10T10:44:32.900' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421162, N'Admin', CAST(N'2022-05-10T10:46:54.737' AS DateTime), CAST(N'2022-05-10T10:46:54.737' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421163, N'Admin', CAST(N'2022-05-10T10:53:40.293' AS DateTime), CAST(N'2022-05-10T10:53:40.293' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421164, N'Admin', CAST(N'2022-05-10T10:56:25.083' AS DateTime), CAST(N'2022-05-10T10:56:25.083' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421165, N'Admin', CAST(N'2022-05-10T10:58:18.153' AS DateTime), CAST(N'2022-05-10T10:58:18.153' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421166, N'Admin', CAST(N'2022-05-10T11:00:11.197' AS DateTime), CAST(N'2022-05-10T11:00:11.197' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421167, N'Admin', CAST(N'2022-05-10T11:01:12.083' AS DateTime), CAST(N'2022-05-10T11:01:12.083' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421168, N'Admin', CAST(N'2022-05-10T11:02:30.120' AS DateTime), CAST(N'2022-05-10T11:02:30.120' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421169, N'Admin', CAST(N'2022-05-10T11:04:26.690' AS DateTime), CAST(N'2022-05-10T11:04:26.690' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421170, N'Admin', CAST(N'2022-05-10T11:05:12.813' AS DateTime), CAST(N'2022-05-10T11:05:12.813' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421171, N'Admin', CAST(N'2022-05-10T11:10:14.487' AS DateTime), CAST(N'2022-05-10T11:10:14.487' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421172, N'Admin', CAST(N'2022-05-10T11:16:00.077' AS DateTime), CAST(N'2022-05-10T11:16:00.077' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421173, N'Admin', CAST(N'2022-05-10T11:16:14.773' AS DateTime), CAST(N'2022-05-10T11:16:14.773' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421174, N'Admin', CAST(N'2022-05-10T11:21:32.740' AS DateTime), CAST(N'2022-05-10T11:21:32.740' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421175, N'Admin', CAST(N'2022-05-10T11:22:54.563' AS DateTime), CAST(N'2022-05-10T11:22:54.567' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421176, N'Admin', CAST(N'2022-05-10T11:24:50.913' AS DateTime), CAST(N'2022-05-10T11:24:50.913' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421177, N'Admin', CAST(N'2022-05-10T11:26:42.380' AS DateTime), CAST(N'2022-05-10T11:26:42.380' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421178, N'Admin', CAST(N'2022-05-10T11:39:40.540' AS DateTime), CAST(N'2022-05-10T11:39:40.540' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421179, N'Admin', CAST(N'2022-05-10T11:39:56.910' AS DateTime), CAST(N'2022-05-10T11:39:56.910' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421180, N'Admin', CAST(N'2022-05-10T11:55:54.277' AS DateTime), CAST(N'2022-05-10T11:55:54.277' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421181, N'Admin', CAST(N'2022-05-10T11:59:07.030' AS DateTime), CAST(N'2022-05-10T11:59:07.030' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (421182, N'Admin', CAST(N'2022-05-10T12:32:25.557' AS DateTime), CAST(N'2022-05-10T12:32:25.557' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431148, N'Admin', CAST(N'2022-05-10T15:14:41.443' AS DateTime), CAST(N'2022-05-10T15:14:41.443' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431149, N'Admin', CAST(N'2022-05-10T15:24:05.373' AS DateTime), CAST(N'2022-05-10T15:24:05.373' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431150, N'Admin', CAST(N'2022-05-10T16:19:46.123' AS DateTime), CAST(N'2022-05-10T16:19:46.123' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431151, N'Admin', CAST(N'2022-05-10T16:33:15.707' AS DateTime), CAST(N'2022-05-10T16:33:15.707' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431152, N'Admin', CAST(N'2022-05-10T16:40:34.207' AS DateTime), CAST(N'2022-05-10T16:40:34.207' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431153, N'Admin', CAST(N'2022-05-10T16:44:03.003' AS DateTime), CAST(N'2022-05-10T16:44:03.003' AS DateTime), N'I', N'')
GO
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431154, N'Admin', CAST(N'2022-05-10T16:45:42.917' AS DateTime), CAST(N'2022-05-10T16:45:42.917' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431155, N'Admin', CAST(N'2022-05-10T16:49:56.740' AS DateTime), CAST(N'2022-05-10T16:49:56.740' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431156, N'Admin', CAST(N'2022-05-10T16:51:10.763' AS DateTime), CAST(N'2022-05-10T16:51:10.763' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431157, N'Admin', CAST(N'2022-05-10T16:54:30.877' AS DateTime), CAST(N'2022-05-10T16:54:30.877' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431158, N'Admin', CAST(N'2022-05-10T16:57:08.387' AS DateTime), CAST(N'2022-05-10T16:57:08.387' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431159, N'Admin', CAST(N'2022-05-10T16:59:08.233' AS DateTime), CAST(N'2022-05-10T16:59:08.233' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431160, N'Admin', CAST(N'2022-05-10T16:59:14.260' AS DateTime), CAST(N'2022-05-10T16:59:14.260' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431161, N'Admin', CAST(N'2022-05-10T17:01:48.623' AS DateTime), CAST(N'2022-05-10T17:01:48.627' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431162, N'Admin', CAST(N'2022-05-10T17:05:58.417' AS DateTime), CAST(N'2022-05-10T17:05:58.417' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431163, N'Admin', CAST(N'2022-05-10T17:08:20.193' AS DateTime), CAST(N'2022-05-10T17:08:20.193' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431164, N'Admin', CAST(N'2022-05-10T17:08:34.060' AS DateTime), CAST(N'2022-05-10T17:08:34.060' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431165, N'Admin', CAST(N'2022-05-10T17:10:24.490' AS DateTime), CAST(N'2022-05-10T17:10:24.490' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431166, N'Admin', CAST(N'2022-05-10T17:10:35.117' AS DateTime), CAST(N'2022-05-10T17:10:35.117' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431167, N'Admin', CAST(N'2022-05-10T17:12:49.087' AS DateTime), CAST(N'2022-05-10T17:12:49.087' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431168, N'Admin', CAST(N'2022-05-10T17:20:12.943' AS DateTime), CAST(N'2022-05-10T17:20:12.943' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431169, N'Admin', CAST(N'2022-05-11T09:07:33.747' AS DateTime), CAST(N'2022-05-11T09:07:33.747' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431170, N'Admin', CAST(N'2022-05-11T09:07:50.613' AS DateTime), CAST(N'2022-05-11T09:07:50.613' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431171, N'Admin', CAST(N'2022-05-11T10:09:10.510' AS DateTime), CAST(N'2022-05-11T10:09:10.510' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431172, N'Admin', CAST(N'2022-05-11T10:41:11.547' AS DateTime), CAST(N'2022-05-11T10:41:11.547' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431173, N'Admin', CAST(N'2022-05-11T11:10:33.037' AS DateTime), CAST(N'2022-05-11T11:10:33.037' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431174, N'Admin', CAST(N'2022-05-11T11:35:41.850' AS DateTime), CAST(N'2022-05-11T11:35:41.850' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431175, N'Admin', CAST(N'2022-05-11T11:38:18.150' AS DateTime), CAST(N'2022-05-11T11:38:18.150' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431176, N'Admin', CAST(N'2022-05-11T11:46:51.083' AS DateTime), CAST(N'2022-05-11T11:46:51.083' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (431177, N'Admin', CAST(N'2022-05-11T11:59:43.987' AS DateTime), CAST(N'2022-05-11T11:59:43.987' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441148, N'Admin', CAST(N'2022-05-11T13:34:27.540' AS DateTime), CAST(N'2022-05-11T13:34:27.540' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441149, N'Admin', CAST(N'2022-05-11T13:44:58.930' AS DateTime), CAST(N'2022-05-11T13:44:58.930' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441150, N'Admin', CAST(N'2022-05-11T13:58:51.043' AS DateTime), CAST(N'2022-05-11T13:58:51.043' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441151, N'Admin', CAST(N'2022-05-11T14:11:02.723' AS DateTime), CAST(N'2022-05-11T14:11:02.723' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441152, N'Admin', CAST(N'2022-05-11T14:17:57.157' AS DateTime), CAST(N'2022-05-11T14:17:57.157' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441153, N'Admin', CAST(N'2022-05-11T14:29:37.343' AS DateTime), CAST(N'2022-05-11T14:29:37.343' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441154, N'Admin', CAST(N'2022-05-11T14:39:17.877' AS DateTime), CAST(N'2022-05-11T14:39:17.877' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441155, N'Admin', CAST(N'2022-05-11T14:44:42.143' AS DateTime), CAST(N'2022-05-11T14:44:42.143' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441156, N'Admin', CAST(N'2022-05-11T14:47:21.707' AS DateTime), CAST(N'2022-05-11T14:47:21.707' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441157, N'Admin', CAST(N'2022-05-11T15:06:48.463' AS DateTime), CAST(N'2022-05-11T15:06:48.463' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441158, N'Admin', CAST(N'2022-05-11T15:41:12.283' AS DateTime), CAST(N'2022-05-11T15:41:12.283' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441159, N'Admin', CAST(N'2022-05-11T16:02:19.237' AS DateTime), CAST(N'2022-05-11T16:02:19.237' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441160, N'Admin', CAST(N'2022-05-11T16:10:20.917' AS DateTime), CAST(N'2022-05-11T16:10:20.917' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441161, N'admin', CAST(N'2022-05-11T16:14:07.257' AS DateTime), CAST(N'2022-05-11T16:14:07.257' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441162, N'admin', CAST(N'2022-05-11T16:16:31.877' AS DateTime), CAST(N'2022-05-11T16:16:31.877' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441163, N'admin', CAST(N'2022-05-11T16:16:38.370' AS DateTime), CAST(N'2022-05-11T16:16:38.370' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441164, N'admin', CAST(N'2022-05-11T16:16:55.053' AS DateTime), CAST(N'2022-05-11T16:16:55.053' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441165, N'admin', CAST(N'2022-05-11T16:20:24.983' AS DateTime), CAST(N'2022-05-11T16:20:24.983' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441166, N'admin', CAST(N'2022-05-11T16:29:13.810' AS DateTime), CAST(N'2022-05-11T16:29:13.810' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441167, N'admin', CAST(N'2022-05-11T16:37:27.337' AS DateTime), CAST(N'2022-05-11T16:37:27.337' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441168, N'admin', CAST(N'2022-05-11T16:41:55.247' AS DateTime), CAST(N'2022-05-11T16:41:55.247' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441169, N'admin', CAST(N'2022-05-11T16:49:21.803' AS DateTime), CAST(N'2022-05-11T16:49:21.803' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441170, N'admin', CAST(N'2022-05-11T16:50:59.387' AS DateTime), CAST(N'2022-05-11T16:50:59.387' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441171, N'tedy', CAST(N'2022-05-11T16:59:29.990' AS DateTime), CAST(N'2022-05-11T16:59:29.990' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441172, N'admin', CAST(N'2022-05-11T17:03:13.167' AS DateTime), CAST(N'2022-05-11T17:03:13.167' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441173, N'admin', CAST(N'2022-05-12T08:24:48.857' AS DateTime), CAST(N'2022-05-12T08:24:48.857' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441174, N'admin', CAST(N'2022-05-12T08:35:14.667' AS DateTime), CAST(N'2022-05-12T08:35:14.667' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441175, N'admin', CAST(N'2022-05-12T08:49:07.770' AS DateTime), CAST(N'2022-05-12T08:49:07.770' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441176, N'admin', CAST(N'2022-05-12T09:00:16.890' AS DateTime), CAST(N'2022-05-12T09:00:16.890' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441177, N'admin', CAST(N'2022-05-12T09:13:08.523' AS DateTime), CAST(N'2022-05-12T09:13:08.523' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (441178, N'admin', CAST(N'2022-05-12T09:26:23.680' AS DateTime), CAST(N'2022-05-12T09:26:23.680' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451148, N'admin', CAST(N'2022-05-12T09:59:48.357' AS DateTime), CAST(N'2022-05-12T09:59:48.360' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451149, N'admin', CAST(N'2022-05-12T10:13:48.643' AS DateTime), CAST(N'2022-05-12T10:13:48.643' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451150, N'admin', CAST(N'2022-05-12T10:53:00.477' AS DateTime), CAST(N'2022-05-12T10:53:00.477' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451151, N'admin', CAST(N'2022-05-12T11:13:43.107' AS DateTime), CAST(N'2022-05-12T11:13:43.107' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451152, N'admin', CAST(N'2022-05-12T11:31:27.023' AS DateTime), CAST(N'2022-05-12T11:31:27.023' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451153, N'admin', CAST(N'2022-05-12T11:32:46.970' AS DateTime), CAST(N'2022-05-12T11:32:46.970' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451154, N'admin', CAST(N'2022-05-12T11:54:07.350' AS DateTime), CAST(N'2022-05-12T11:54:07.350' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451155, N'admin', CAST(N'2022-05-12T12:02:36.573' AS DateTime), CAST(N'2022-05-12T12:02:36.573' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451156, N'admin', CAST(N'2022-05-12T12:37:23.757' AS DateTime), CAST(N'2022-05-12T12:37:23.757' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451157, N'admin', CAST(N'2022-05-12T13:43:06.377' AS DateTime), CAST(N'2022-05-12T13:43:06.377' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451158, N'admin', CAST(N'2022-05-12T13:45:57.123' AS DateTime), CAST(N'2022-05-12T13:45:57.123' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451159, N'admin', CAST(N'2022-05-12T13:51:28.107' AS DateTime), CAST(N'2022-05-12T13:51:28.110' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451160, N'admin', CAST(N'2022-05-12T13:53:38.783' AS DateTime), CAST(N'2022-05-12T13:53:38.783' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451161, N'admin', CAST(N'2022-05-12T13:53:49.097' AS DateTime), CAST(N'2022-05-12T13:53:49.097' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (451162, N'admin', CAST(N'2022-05-12T13:54:06.663' AS DateTime), CAST(N'2022-05-12T13:54:06.663' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (461148, N'admin', CAST(N'2022-05-12T15:14:45.790' AS DateTime), CAST(N'2022-05-12T15:14:45.790' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471148, N'admin', CAST(N'2022-05-12T15:33:02.363' AS DateTime), CAST(N'2022-05-12T15:33:02.363' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471149, N'admin', CAST(N'2022-05-13T09:04:32.023' AS DateTime), CAST(N'2022-05-13T09:04:32.023' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471150, N'admin', CAST(N'2022-05-13T09:15:30.317' AS DateTime), CAST(N'2022-05-13T09:15:30.317' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471151, N'admin', CAST(N'2022-05-13T09:19:35.560' AS DateTime), CAST(N'2022-05-13T09:19:35.560' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471152, N'admin', CAST(N'2022-05-13T09:24:05.127' AS DateTime), CAST(N'2022-05-13T09:24:05.127' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471153, N'admin', CAST(N'2022-05-13T09:26:26.203' AS DateTime), CAST(N'2022-05-13T09:26:26.203' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471154, N'admin', CAST(N'2022-05-13T09:28:00.063' AS DateTime), CAST(N'2022-05-13T09:28:00.063' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471155, N'admin', CAST(N'2022-05-13T09:31:15.460' AS DateTime), CAST(N'2022-05-13T09:31:15.460' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471156, N'admin', CAST(N'2022-05-13T09:36:55.583' AS DateTime), CAST(N'2022-05-13T09:36:55.583' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471157, N'admin', CAST(N'2022-05-13T09:39:23.653' AS DateTime), CAST(N'2022-05-13T09:39:23.653' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471158, N'admin', CAST(N'2022-05-13T09:39:31.897' AS DateTime), CAST(N'2022-05-13T09:39:31.897' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471159, N'admin', CAST(N'2022-05-13T09:41:21.280' AS DateTime), CAST(N'2022-05-13T09:41:21.280' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471160, N'admin', CAST(N'2022-05-13T09:46:39.530' AS DateTime), CAST(N'2022-05-13T09:46:39.530' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471161, N'admin', CAST(N'2022-05-13T10:07:47.123' AS DateTime), CAST(N'2022-05-13T10:07:47.123' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471162, N'admin', CAST(N'2022-05-13T10:14:09.590' AS DateTime), CAST(N'2022-05-13T10:14:09.590' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471163, N'admin', CAST(N'2022-05-13T10:27:11.053' AS DateTime), CAST(N'2022-05-13T10:27:11.053' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471164, N'admin', CAST(N'2022-05-13T10:47:54.420' AS DateTime), CAST(N'2022-05-13T10:47:54.420' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471165, N'admin', CAST(N'2022-05-13T10:54:31.513' AS DateTime), CAST(N'2022-05-13T10:54:31.513' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471166, N'admin', CAST(N'2022-05-13T10:59:19.140' AS DateTime), CAST(N'2022-05-13T10:59:19.140' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471167, N'admin', CAST(N'2022-05-13T11:08:14.057' AS DateTime), CAST(N'2022-05-13T11:08:14.057' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471168, N'admin', CAST(N'2022-05-13T11:09:38.943' AS DateTime), CAST(N'2022-05-13T11:09:38.943' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471169, N'admin', CAST(N'2022-05-13T11:26:14.613' AS DateTime), CAST(N'2022-05-13T11:26:14.613' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471170, N'admin', CAST(N'2022-05-13T11:39:13.750' AS DateTime), CAST(N'2022-05-13T11:39:13.750' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471171, N'admin', CAST(N'2022-05-13T11:47:02.387' AS DateTime), CAST(N'2022-05-13T11:47:02.387' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471172, N'admin', CAST(N'2022-05-13T11:57:56.497' AS DateTime), CAST(N'2022-05-13T11:57:56.497' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471173, N'admin', CAST(N'2022-05-13T12:03:05.960' AS DateTime), CAST(N'2022-05-13T12:03:05.960' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471174, N'admin', CAST(N'2022-05-13T13:25:56.627' AS DateTime), CAST(N'2022-05-13T13:25:56.627' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471175, N'admin', CAST(N'2022-05-13T13:45:57.653' AS DateTime), CAST(N'2022-05-13T13:45:57.653' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471176, N'admin', CAST(N'2022-05-13T13:50:20.137' AS DateTime), CAST(N'2022-05-13T13:50:20.137' AS DateTime), N'I', N'')
GO
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471177, N'admin', CAST(N'2022-05-13T13:53:07.020' AS DateTime), CAST(N'2022-05-13T13:53:07.020' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471178, N'admin', CAST(N'2022-05-13T14:06:40.180' AS DateTime), CAST(N'2022-05-13T14:06:40.180' AS DateTime), N'I', N'DESKTOP-1N13BGF')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471179, N'admin', CAST(N'2022-05-13T14:11:07.890' AS DateTime), CAST(N'2022-05-13T14:11:07.890' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471180, N'admin', CAST(N'2022-05-13T14:15:59.560' AS DateTime), CAST(N'2022-05-13T14:15:59.560' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471181, N'admin', CAST(N'2022-05-13T14:16:47.197' AS DateTime), CAST(N'2022-05-13T14:16:47.197' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471182, N'admin', CAST(N'2022-05-13T14:25:26.170' AS DateTime), CAST(N'2022-05-13T14:25:26.170' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471183, N'admin', CAST(N'2022-05-13T14:41:06.310' AS DateTime), CAST(N'2022-05-13T14:41:06.310' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471184, N'admin', CAST(N'2022-05-13T14:41:25.520' AS DateTime), CAST(N'2022-05-13T14:41:25.520' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471185, N'admin', CAST(N'2022-05-13T14:42:26.143' AS DateTime), CAST(N'2022-05-13T14:42:26.143' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471186, N'admin', CAST(N'2022-05-13T14:48:32.337' AS DateTime), CAST(N'2022-05-13T14:48:32.337' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471187, N'admin', CAST(N'2022-05-13T14:51:53.187' AS DateTime), CAST(N'2022-05-13T14:51:53.187' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471188, N'admin', CAST(N'2022-05-13T14:54:03.960' AS DateTime), CAST(N'2022-05-13T14:54:03.960' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471189, N'admin', CAST(N'2022-05-13T14:55:49.797' AS DateTime), CAST(N'2022-05-13T14:55:49.797' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471190, N'admin', CAST(N'2022-05-13T14:56:03.750' AS DateTime), CAST(N'2022-05-13T14:56:03.750' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471191, N'admin', CAST(N'2022-05-13T15:25:53.160' AS DateTime), CAST(N'2022-05-13T15:25:53.160' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471192, N'admin', CAST(N'2022-05-13T15:44:29.003' AS DateTime), CAST(N'2022-05-13T15:44:29.003' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471193, N'admin', CAST(N'2022-05-13T15:45:13.563' AS DateTime), CAST(N'2022-05-13T15:45:13.563' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471194, N'admin', CAST(N'2022-05-13T16:00:32.230' AS DateTime), CAST(N'2022-05-13T16:00:32.230' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471195, N'admin', CAST(N'2022-05-13T16:11:22.363' AS DateTime), CAST(N'2022-05-13T16:11:22.363' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471196, N'admin', CAST(N'2022-05-13T16:24:37.723' AS DateTime), CAST(N'2022-05-13T16:24:37.723' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471197, N'admin', CAST(N'2022-05-13T16:45:30.417' AS DateTime), CAST(N'2022-05-13T16:45:30.417' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471198, N'admin', CAST(N'2022-05-13T17:27:48.077' AS DateTime), CAST(N'2022-05-13T17:27:48.077' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471199, N'admin', CAST(N'2022-05-14T09:37:36.357' AS DateTime), CAST(N'2022-05-14T09:37:36.357' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471200, N'admin', CAST(N'2022-05-14T09:42:01.633' AS DateTime), CAST(N'2022-05-14T09:42:01.633' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471201, N'admin', CAST(N'2022-05-14T09:45:35.817' AS DateTime), CAST(N'2022-05-14T09:45:35.817' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471202, N'admin', CAST(N'2022-05-14T09:48:32.997' AS DateTime), CAST(N'2022-05-14T09:48:32.997' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471203, N'tedy', CAST(N'2022-05-14T09:59:02.557' AS DateTime), CAST(N'2022-05-14T09:59:02.557' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471204, N'abdu', CAST(N'2022-05-14T10:02:31.217' AS DateTime), CAST(N'2022-05-14T10:02:31.217' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471205, N'admin', CAST(N'2022-05-14T10:20:08.333' AS DateTime), CAST(N'2022-05-14T10:20:08.333' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471206, N'admin', CAST(N'2022-05-14T10:28:36.680' AS DateTime), CAST(N'2022-05-14T10:28:36.680' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471207, N'admin', CAST(N'2022-05-14T10:30:23.660' AS DateTime), CAST(N'2022-05-14T10:30:23.660' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471208, N'admin', CAST(N'2022-05-14T10:39:16.997' AS DateTime), CAST(N'2022-05-14T10:39:16.997' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471209, N'admin', CAST(N'2022-05-14T10:47:42.153' AS DateTime), CAST(N'2022-05-14T10:47:42.153' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471210, N'admin', CAST(N'2022-05-14T11:18:00.387' AS DateTime), CAST(N'2022-05-14T11:18:00.387' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471211, N'admin', CAST(N'2022-05-14T11:31:20.967' AS DateTime), CAST(N'2022-05-14T11:31:20.967' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471212, N'admin', CAST(N'2022-05-14T11:45:36.513' AS DateTime), CAST(N'2022-05-14T11:45:36.513' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471213, N'admin', CAST(N'2022-05-14T12:09:16.147' AS DateTime), CAST(N'2022-05-14T12:09:16.147' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471214, N'admin', CAST(N'2022-05-14T12:20:30.163' AS DateTime), CAST(N'2022-05-14T12:20:30.163' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471215, N'admin', CAST(N'2022-05-14T12:38:00.047' AS DateTime), CAST(N'2022-05-14T12:38:00.047' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471216, N'alayu', CAST(N'2022-05-14T12:38:31.960' AS DateTime), CAST(N'2022-05-14T12:38:31.960' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471217, N'admin', CAST(N'2022-05-14T12:47:30.800' AS DateTime), CAST(N'2022-05-14T12:47:30.800' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471218, N'admin', CAST(N'2022-05-14T13:04:07.543' AS DateTime), CAST(N'2022-05-14T13:04:07.543' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471219, N'alayu', CAST(N'2022-05-14T13:04:51.740' AS DateTime), CAST(N'2022-05-14T13:04:51.740' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471220, N'admin', CAST(N'2022-05-14T13:10:31.900' AS DateTime), CAST(N'2022-05-14T13:10:31.900' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471221, N'admin', CAST(N'2022-05-14T13:26:59.387' AS DateTime), CAST(N'2022-05-14T13:26:59.387' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471222, N'admin', CAST(N'2022-05-14T13:37:02.443' AS DateTime), CAST(N'2022-05-14T13:37:02.443' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471223, N'admin', CAST(N'2022-05-14T13:38:26.200' AS DateTime), CAST(N'2022-05-14T13:38:26.200' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471224, N'admin', CAST(N'2022-05-14T13:39:40.753' AS DateTime), CAST(N'2022-05-14T13:39:40.753' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471225, N'admin', CAST(N'2022-05-14T13:48:33.217' AS DateTime), CAST(N'2022-05-14T13:48:33.217' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471226, N'admin', CAST(N'2022-05-14T13:59:00.387' AS DateTime), CAST(N'2022-05-14T13:59:00.387' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471227, N'admin', CAST(N'2022-05-16T08:50:36.453' AS DateTime), CAST(N'2022-05-16T08:50:36.453' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471228, N'admin', CAST(N'2022-05-16T09:05:58.357' AS DateTime), CAST(N'2022-05-16T09:05:58.357' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471229, N'tedy', CAST(N'2022-05-16T09:08:03.973' AS DateTime), CAST(N'2022-05-16T09:08:03.973' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471230, N'admin', CAST(N'2022-05-16T09:08:45.257' AS DateTime), CAST(N'2022-05-16T09:08:45.257' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471231, N'admin', CAST(N'2022-05-16T09:41:44.250' AS DateTime), CAST(N'2022-05-16T09:41:44.250' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471232, N'admin', CAST(N'2022-05-16T09:43:57.020' AS DateTime), CAST(N'2022-05-16T09:43:57.020' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471233, N'admin', CAST(N'2022-05-16T09:58:00.693' AS DateTime), CAST(N'2022-05-16T09:58:00.693' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471234, N'admin', CAST(N'2022-05-16T10:00:52.010' AS DateTime), CAST(N'2022-05-16T10:00:52.010' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471235, N'admin', CAST(N'2022-05-16T10:01:38.610' AS DateTime), CAST(N'2022-05-16T10:01:38.610' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471236, N'admin', CAST(N'2022-05-16T10:04:36.300' AS DateTime), CAST(N'2022-05-16T10:04:36.300' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471237, N'admin', CAST(N'2022-05-16T10:05:29.143' AS DateTime), CAST(N'2022-05-16T10:05:29.143' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471238, N'admin', CAST(N'2022-05-16T10:06:33.620' AS DateTime), CAST(N'2022-05-16T10:06:33.620' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471239, N'admin', CAST(N'2022-05-16T10:06:54.870' AS DateTime), CAST(N'2022-05-16T10:06:54.870' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471240, N'admin', CAST(N'2022-05-16T10:11:18.983' AS DateTime), CAST(N'2022-05-16T10:11:18.983' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471241, N'admin', CAST(N'2022-05-16T10:20:34.000' AS DateTime), CAST(N'2022-05-16T10:20:34.003' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471242, N'admin', CAST(N'2022-05-16T10:21:39.103' AS DateTime), CAST(N'2022-05-16T10:21:39.103' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471243, N'admin', CAST(N'2022-05-16T10:22:04.920' AS DateTime), CAST(N'2022-05-16T10:22:04.920' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471244, N'admin', CAST(N'2022-05-16T10:26:00.347' AS DateTime), CAST(N'2022-05-16T10:26:00.347' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471245, N'admin', CAST(N'2022-05-16T10:27:12.497' AS DateTime), CAST(N'2022-05-16T10:27:12.497' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471246, N'admin', CAST(N'2022-05-16T10:33:08.063' AS DateTime), CAST(N'2022-05-16T10:33:08.063' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471247, N'admin', CAST(N'2022-05-16T10:36:09.360' AS DateTime), CAST(N'2022-05-16T10:36:09.360' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471248, N'admin', CAST(N'2022-05-16T10:38:02.437' AS DateTime), CAST(N'2022-05-16T10:38:02.437' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471249, N'admin', CAST(N'2022-05-16T10:42:30.290' AS DateTime), CAST(N'2022-05-16T10:42:30.290' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471250, N'admin', CAST(N'2022-05-16T10:43:10.753' AS DateTime), CAST(N'2022-05-16T10:43:10.753' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471251, N'admin', CAST(N'2022-05-16T10:44:01.703' AS DateTime), CAST(N'2022-05-16T10:44:01.703' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471252, N'admin', CAST(N'2022-05-16T10:56:48.460' AS DateTime), CAST(N'2022-05-16T10:56:48.460' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471253, N'admin', CAST(N'2022-05-16T11:00:52.340' AS DateTime), CAST(N'2022-05-16T11:00:52.340' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471254, N'admin', CAST(N'2022-05-16T11:04:56.110' AS DateTime), CAST(N'2022-05-16T11:04:56.110' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471255, N'admin', CAST(N'2022-05-16T11:08:28.427' AS DateTime), CAST(N'2022-05-16T11:08:28.427' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471256, N'admin', CAST(N'2022-05-16T11:19:13.803' AS DateTime), CAST(N'2022-05-16T11:19:13.803' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471257, N'admin', CAST(N'2022-05-16T11:19:41.820' AS DateTime), CAST(N'2022-05-16T11:19:41.820' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471258, N'admin', CAST(N'2022-05-16T11:20:59.517' AS DateTime), CAST(N'2022-05-16T11:20:59.517' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471259, N'admin', CAST(N'2022-05-16T11:25:32.250' AS DateTime), CAST(N'2022-05-16T11:25:32.250' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471260, N'admin', CAST(N'2022-05-16T11:27:15.130' AS DateTime), CAST(N'2022-05-16T11:27:15.133' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471261, N'admin', CAST(N'2022-05-16T11:28:31.900' AS DateTime), CAST(N'2022-05-16T11:28:31.900' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471262, N'admin', CAST(N'2022-05-16T11:29:42.480' AS DateTime), CAST(N'2022-05-16T11:29:42.480' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471263, N'admin', CAST(N'2022-05-16T11:29:57.303' AS DateTime), CAST(N'2022-05-16T11:29:57.303' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471264, N'admin', CAST(N'2022-05-16T11:30:38.173' AS DateTime), CAST(N'2022-05-16T11:30:38.173' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471265, N'admin', CAST(N'2022-05-16T11:32:45.490' AS DateTime), CAST(N'2022-05-16T11:32:45.490' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471266, N'admin', CAST(N'2022-05-16T11:33:14.273' AS DateTime), CAST(N'2022-05-16T11:33:14.273' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471267, N'admin', CAST(N'2022-05-16T11:35:13.827' AS DateTime), CAST(N'2022-05-16T11:35:13.827' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471268, N'admin', CAST(N'2022-05-16T11:35:40.767' AS DateTime), CAST(N'2022-05-16T11:35:40.767' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471269, N'admin', CAST(N'2022-05-16T11:38:57.880' AS DateTime), CAST(N'2022-05-16T11:38:57.880' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471270, N'admin', CAST(N'2022-05-16T12:05:08.757' AS DateTime), CAST(N'2022-05-16T12:05:08.757' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471271, N'admin', CAST(N'2022-05-16T12:05:42.100' AS DateTime), CAST(N'2022-05-16T12:05:42.100' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471272, N'admin', CAST(N'2022-05-16T12:06:03.427' AS DateTime), CAST(N'2022-05-16T12:06:03.427' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471273, N'admin', CAST(N'2022-05-16T12:06:12.077' AS DateTime), CAST(N'2022-05-16T12:06:12.077' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471274, N'admin', CAST(N'2022-05-17T08:49:52.227' AS DateTime), CAST(N'2022-05-17T08:49:52.227' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471275, N'admin', CAST(N'2022-05-17T08:51:45.560' AS DateTime), CAST(N'2022-05-17T08:51:45.560' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471276, N'admin', CAST(N'2022-05-17T08:53:29.960' AS DateTime), CAST(N'2022-05-17T08:53:29.960' AS DateTime), N'I', N'')
GO
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471277, N'admin', CAST(N'2022-05-17T08:57:19.100' AS DateTime), CAST(N'2022-05-17T08:57:19.100' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471278, N'admin', CAST(N'2022-05-17T09:09:50.980' AS DateTime), CAST(N'2022-05-17T09:09:50.980' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471279, N'admin', CAST(N'2022-05-17T09:11:43.400' AS DateTime), CAST(N'2022-05-17T09:11:43.400' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471280, N'admin', CAST(N'2022-05-17T09:14:03.027' AS DateTime), CAST(N'2022-05-17T09:14:03.027' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471281, N'admin', CAST(N'2022-05-17T09:19:15.167' AS DateTime), CAST(N'2022-05-17T09:19:15.167' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471282, N'admin', CAST(N'2022-05-17T09:20:46.347' AS DateTime), CAST(N'2022-05-17T09:20:46.347' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471283, N'admin', CAST(N'2022-05-17T09:25:17.237' AS DateTime), CAST(N'2022-05-17T09:25:17.237' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471284, N'admin', CAST(N'2022-05-17T09:36:34.860' AS DateTime), CAST(N'2022-05-17T09:36:34.860' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471285, N'admin', CAST(N'2022-05-17T09:37:22.927' AS DateTime), CAST(N'2022-05-17T09:37:22.927' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471286, N'admin', CAST(N'2022-05-17T09:48:42.833' AS DateTime), CAST(N'2022-05-17T09:48:42.833' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471287, N'admin', CAST(N'2022-05-17T09:50:12.493' AS DateTime), CAST(N'2022-05-17T09:50:12.493' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471288, N'admin', CAST(N'2022-05-17T10:13:30.557' AS DateTime), CAST(N'2022-05-17T10:13:30.557' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471289, N'admin', CAST(N'2022-05-17T10:18:07.217' AS DateTime), CAST(N'2022-05-17T10:18:07.217' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471290, N'admin', CAST(N'2022-05-17T10:26:45.117' AS DateTime), CAST(N'2022-05-17T10:26:45.117' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471291, N'admin', CAST(N'2022-05-17T10:45:39.477' AS DateTime), CAST(N'2022-05-17T10:45:39.477' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471292, N'admin', CAST(N'2022-05-17T11:18:00.343' AS DateTime), CAST(N'2022-05-17T11:18:00.343' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471293, N'admin', CAST(N'2022-05-17T11:19:00.887' AS DateTime), CAST(N'2022-05-17T11:19:00.887' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471294, N'admin', CAST(N'2022-05-17T11:26:56.967' AS DateTime), CAST(N'2022-05-17T11:26:56.967' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471295, N'admin', CAST(N'2022-05-17T11:29:35.377' AS DateTime), CAST(N'2022-05-17T11:29:35.377' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471296, N'admin', CAST(N'2022-05-17T11:35:22.283' AS DateTime), CAST(N'2022-05-17T11:35:22.283' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471297, N'admin', CAST(N'2022-05-17T11:42:11.793' AS DateTime), CAST(N'2022-05-17T11:42:11.793' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471298, N'admin', CAST(N'2022-05-17T11:49:53.327' AS DateTime), CAST(N'2022-05-17T11:49:53.327' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471299, N'admin', CAST(N'2022-05-17T11:58:51.237' AS DateTime), CAST(N'2022-05-17T11:58:51.237' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471300, N'admin', CAST(N'2022-05-17T12:14:45.513' AS DateTime), CAST(N'2022-05-17T12:14:45.513' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471301, N'admin', CAST(N'2022-05-17T12:17:28.043' AS DateTime), CAST(N'2022-05-17T12:17:28.043' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471302, N'admin', CAST(N'2022-05-17T12:24:31.573' AS DateTime), CAST(N'2022-05-17T12:24:31.573' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471303, N'admin', CAST(N'2022-05-17T13:22:26.087' AS DateTime), CAST(N'2022-05-17T13:22:26.087' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471304, N'admin', CAST(N'2022-05-17T13:38:26.853' AS DateTime), CAST(N'2022-05-17T13:38:26.853' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471305, N'admin', CAST(N'2022-05-17T13:38:59.000' AS DateTime), CAST(N'2022-05-17T13:38:59.000' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471306, N'admin', CAST(N'2022-05-17T13:39:26.277' AS DateTime), CAST(N'2022-05-17T13:39:26.277' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471307, N'admin', CAST(N'2022-05-17T13:40:30.180' AS DateTime), CAST(N'2022-05-17T13:40:30.180' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471308, N'admin', CAST(N'2022-05-17T13:43:40.357' AS DateTime), CAST(N'2022-05-17T13:43:40.357' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471309, N'admin', CAST(N'2022-05-17T13:56:43.070' AS DateTime), CAST(N'2022-05-17T13:56:43.070' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471310, N'admin', CAST(N'2022-05-17T14:01:16.720' AS DateTime), CAST(N'2022-05-17T14:01:16.720' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471311, N'admin', CAST(N'2022-05-17T14:09:35.067' AS DateTime), CAST(N'2022-05-17T14:09:35.067' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471312, N'admin', CAST(N'2022-05-17T14:17:36.167' AS DateTime), CAST(N'2022-05-17T14:17:36.167' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471313, N'admin', CAST(N'2022-05-17T14:30:01.063' AS DateTime), CAST(N'2022-05-17T14:30:01.063' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471314, N'admin', CAST(N'2022-05-17T14:39:13.593' AS DateTime), CAST(N'2022-05-17T14:39:13.593' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471315, N'admin', CAST(N'2022-05-17T14:56:23.837' AS DateTime), CAST(N'2022-05-17T14:56:23.837' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471316, N'admin', CAST(N'2022-05-17T15:03:31.470' AS DateTime), CAST(N'2022-05-17T15:03:31.470' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471317, N'admin', CAST(N'2022-05-17T15:05:31.777' AS DateTime), CAST(N'2022-05-17T15:05:31.777' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471318, N'admin', CAST(N'2022-05-17T15:10:45.537' AS DateTime), CAST(N'2022-05-17T15:10:45.537' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471319, N'admin', CAST(N'2022-05-17T15:21:28.657' AS DateTime), CAST(N'2022-05-17T15:21:28.657' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471320, N'admin', CAST(N'2022-05-17T15:37:11.283' AS DateTime), CAST(N'2022-05-17T15:37:11.283' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471321, N'admin', CAST(N'2022-05-17T15:43:59.367' AS DateTime), CAST(N'2022-05-17T15:43:59.367' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471322, N'admin', CAST(N'2022-05-17T15:47:15.383' AS DateTime), CAST(N'2022-05-17T15:47:15.383' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471323, N'admin', CAST(N'2022-05-17T15:50:13.683' AS DateTime), CAST(N'2022-05-17T15:50:13.683' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471324, N'admin', CAST(N'2022-05-17T15:53:03.283' AS DateTime), CAST(N'2022-05-17T15:53:03.283' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471325, N'admin', CAST(N'2022-05-17T15:53:26.233' AS DateTime), CAST(N'2022-05-17T15:53:26.233' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471326, N'admin', CAST(N'2022-05-17T15:56:34.147' AS DateTime), CAST(N'2022-05-17T15:56:34.147' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471327, N'admin', CAST(N'2022-05-17T15:59:41.800' AS DateTime), CAST(N'2022-05-17T15:59:41.800' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471328, N'admin', CAST(N'2022-05-17T16:00:29.500' AS DateTime), CAST(N'2022-05-17T16:00:29.500' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471329, N'admin', CAST(N'2022-05-17T16:12:58.957' AS DateTime), CAST(N'2022-05-17T16:12:58.957' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471330, N'admin', CAST(N'2022-05-17T16:25:16.773' AS DateTime), CAST(N'2022-05-17T16:25:16.777' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471331, N'admin', CAST(N'2022-05-17T16:59:15.660' AS DateTime), CAST(N'2022-05-17T16:59:15.660' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471332, N'admin', CAST(N'2022-05-18T08:23:27.473' AS DateTime), CAST(N'2022-05-18T08:23:27.473' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471333, N'admin', CAST(N'2022-05-18T08:31:08.970' AS DateTime), CAST(N'2022-05-18T08:31:08.970' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471334, N'admin', CAST(N'2022-05-18T08:47:23.470' AS DateTime), CAST(N'2022-05-18T08:47:23.470' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471335, N'admin', CAST(N'2022-05-18T08:47:56.283' AS DateTime), CAST(N'2022-05-18T08:47:56.283' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471336, N'admin', CAST(N'2022-05-18T08:51:20.613' AS DateTime), CAST(N'2022-05-18T08:51:20.613' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471337, N'admin', CAST(N'2022-05-18T08:57:41.303' AS DateTime), CAST(N'2022-05-18T08:57:41.303' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471338, N'admin', CAST(N'2022-05-18T09:15:22.323' AS DateTime), CAST(N'2022-05-18T09:15:22.323' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471339, N'admin', CAST(N'2022-05-18T09:16:19.940' AS DateTime), CAST(N'2022-05-18T09:16:19.940' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471340, N'admin', CAST(N'2022-05-18T09:17:48.103' AS DateTime), CAST(N'2022-05-18T09:17:48.103' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471341, N'admin', CAST(N'2022-05-18T09:18:22.607' AS DateTime), CAST(N'2022-05-18T09:18:22.607' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471342, N'admin', CAST(N'2022-05-18T09:19:22.273' AS DateTime), CAST(N'2022-05-18T09:19:22.273' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471343, N'admin', CAST(N'2022-05-21T09:17:46.413' AS DateTime), CAST(N'2022-05-21T09:17:46.413' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471344, N'admin', CAST(N'2022-05-24T04:49:03.713' AS DateTime), CAST(N'2022-05-24T04:49:03.713' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471345, N'admin', CAST(N'2022-05-24T04:49:57.413' AS DateTime), CAST(N'2022-05-24T04:49:57.413' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471346, N'admin', CAST(N'2022-05-24T22:00:46.127' AS DateTime), CAST(N'2022-05-24T22:00:46.127' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471347, N'admin', CAST(N'2022-05-24T22:15:58.690' AS DateTime), CAST(N'2022-05-24T22:15:58.690' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471348, N'admin', CAST(N'2022-05-24T22:21:42.100' AS DateTime), CAST(N'2022-05-24T22:21:42.100' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471349, N'admin', CAST(N'2022-05-24T22:33:34.610' AS DateTime), CAST(N'2022-05-24T22:33:34.610' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471350, N'biruke', CAST(N'2022-05-24T22:52:38.810' AS DateTime), CAST(N'2022-05-24T22:52:38.810' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471351, N'biruke', CAST(N'2022-05-24T22:52:48.427' AS DateTime), CAST(N'2022-05-24T22:52:48.427' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471352, N'biruke', CAST(N'2022-05-24T22:53:02.493' AS DateTime), CAST(N'2022-05-24T22:53:02.493' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471353, N'biruke', CAST(N'2022-05-24T22:57:06.737' AS DateTime), CAST(N'2022-05-24T22:57:06.737' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471354, N'biruke', CAST(N'2022-05-24T22:59:22.167' AS DateTime), CAST(N'2022-05-24T22:59:22.167' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471355, N'biruke', CAST(N'2022-05-24T23:00:52.090' AS DateTime), CAST(N'2022-05-24T23:00:52.090' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471356, N'biruke', CAST(N'2022-05-24T23:02:11.353' AS DateTime), CAST(N'2022-05-24T23:02:11.353' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471357, N'biruke', CAST(N'2022-05-24T23:07:57.460' AS DateTime), CAST(N'2022-05-24T23:07:57.460' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471358, N'gech', CAST(N'2022-05-24T23:11:26.237' AS DateTime), CAST(N'2022-05-24T23:11:26.237' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471359, N'gech', CAST(N'2022-05-24T23:12:02.670' AS DateTime), CAST(N'2022-05-24T23:12:02.670' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471360, N'gech', CAST(N'2022-05-24T23:12:19.447' AS DateTime), CAST(N'2022-05-24T23:12:19.447' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471361, N'naty', CAST(N'2022-05-24T23:13:38.520' AS DateTime), CAST(N'2022-05-24T23:13:38.520' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471362, N'gech', CAST(N'2022-05-24T23:13:46.210' AS DateTime), CAST(N'2022-05-24T23:13:46.210' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471363, N'gech', CAST(N'2022-05-24T23:13:59.283' AS DateTime), CAST(N'2022-05-24T23:13:59.283' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471364, N'biruke', CAST(N'2022-05-24T23:14:07.780' AS DateTime), CAST(N'2022-05-24T23:14:07.780' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471365, N'gech', CAST(N'2022-05-24T23:15:06.850' AS DateTime), CAST(N'2022-05-24T23:15:06.850' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471366, N'gech', CAST(N'2022-05-24T23:25:21.357' AS DateTime), CAST(N'2022-05-24T23:25:21.357' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471367, N'biruke', CAST(N'2022-05-24T23:32:31.667' AS DateTime), CAST(N'2022-05-24T23:32:31.667' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471368, N'biruke', CAST(N'2022-05-24T23:37:45.967' AS DateTime), CAST(N'2022-05-24T23:37:45.967' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471369, N'biruke', CAST(N'2022-05-25T00:00:54.930' AS DateTime), CAST(N'2022-05-25T00:00:54.930' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471370, N'biruke', CAST(N'2022-05-25T00:03:56.400' AS DateTime), CAST(N'2022-05-25T00:03:56.400' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471371, N'biruke', CAST(N'2022-05-25T00:05:20.683' AS DateTime), CAST(N'2022-05-25T00:05:20.683' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471372, N'biruke', CAST(N'2022-05-25T00:07:46.187' AS DateTime), CAST(N'2022-05-25T00:07:46.187' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471373, N'biruke', CAST(N'2022-05-25T00:15:47.310' AS DateTime), CAST(N'2022-05-25T00:15:47.310' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471374, N'biruke', CAST(N'2022-05-25T00:20:40.227' AS DateTime), CAST(N'2022-05-25T00:20:40.227' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471375, N'biruke', CAST(N'2022-05-25T00:23:30.943' AS DateTime), CAST(N'2022-05-25T00:23:30.943' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471376, N'biruke', CAST(N'2022-05-25T00:23:59.363' AS DateTime), CAST(N'2022-05-25T00:23:59.363' AS DateTime), N'I', N'')
GO
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471377, N'biruke', CAST(N'2022-05-25T00:24:35.017' AS DateTime), CAST(N'2022-05-25T00:24:35.017' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471378, N'biruke', CAST(N'2022-05-25T00:25:24.723' AS DateTime), CAST(N'2022-05-25T00:25:24.723' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471379, N'biruke', CAST(N'2022-05-25T00:32:26.950' AS DateTime), CAST(N'2022-05-25T00:32:26.950' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471380, N'biruke', CAST(N'2022-05-25T00:44:35.967' AS DateTime), CAST(N'2022-05-25T00:44:35.967' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471381, N'biruke', CAST(N'2022-05-25T00:59:42.317' AS DateTime), CAST(N'2022-05-25T00:59:42.317' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471382, N'biruke', CAST(N'2022-05-25T01:06:27.403' AS DateTime), CAST(N'2022-05-25T01:06:27.403' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471383, N'biruke', CAST(N'2022-05-25T01:08:19.077' AS DateTime), CAST(N'2022-05-25T01:08:19.077' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471384, N'biruke', CAST(N'2022-05-25T01:10:29.277' AS DateTime), CAST(N'2022-05-25T01:10:29.277' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471385, N'tedy', CAST(N'2022-05-25T01:14:10.697' AS DateTime), CAST(N'2022-05-25T01:14:10.697' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471386, N'biruke', CAST(N'2022-05-25T01:20:04.183' AS DateTime), CAST(N'2022-05-25T01:20:04.183' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471387, N'gech', CAST(N'2022-05-25T01:24:36.147' AS DateTime), CAST(N'2022-05-25T01:24:36.147' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471388, N'biruke', CAST(N'2022-05-25T01:32:46.433' AS DateTime), CAST(N'2022-05-25T01:32:46.433' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471389, N'tedy', CAST(N'2022-05-25T01:42:25.863' AS DateTime), CAST(N'2022-05-25T01:42:25.863' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471390, N'gech', CAST(N'2022-05-25T01:51:32.467' AS DateTime), CAST(N'2022-05-25T01:51:32.467' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471391, N'biruke', CAST(N'2022-05-25T03:32:20.013' AS DateTime), CAST(N'2022-05-25T03:32:20.013' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471392, N'biruke', CAST(N'2022-05-25T04:16:03.470' AS DateTime), CAST(N'2022-05-25T04:16:03.470' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471393, N'gech', CAST(N'2022-05-25T04:19:29.633' AS DateTime), CAST(N'2022-05-25T04:19:29.633' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471394, N'biruke', CAST(N'2022-05-25T04:23:43.263' AS DateTime), CAST(N'2022-05-25T04:23:43.263' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471395, N'biruke', CAST(N'2022-05-25T05:07:15.833' AS DateTime), CAST(N'2022-05-25T05:07:15.833' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471396, N'alex', CAST(N'2022-05-25T05:25:45.340' AS DateTime), CAST(N'2022-05-25T05:25:45.340' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471397, N'gech', CAST(N'2022-05-25T05:29:53.243' AS DateTime), CAST(N'2022-05-25T05:29:53.243' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471398, N'biruke', CAST(N'2022-05-25T05:44:53.253' AS DateTime), CAST(N'2022-05-25T05:44:53.253' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471399, N'alex', CAST(N'2022-05-25T05:45:03.337' AS DateTime), CAST(N'2022-05-25T05:45:03.337' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471400, N'biruke', CAST(N'2022-05-25T06:02:33.063' AS DateTime), CAST(N'2022-05-25T06:02:33.063' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471401, N'alex', CAST(N'2022-05-25T06:04:01.850' AS DateTime), CAST(N'2022-05-25T06:04:01.850' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471402, N'alayu', CAST(N'2022-05-25T06:04:53.417' AS DateTime), CAST(N'2022-05-25T06:04:53.417' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471403, N'alayu', CAST(N'2022-05-25T06:05:05.467' AS DateTime), CAST(N'2022-05-25T06:05:05.467' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471404, N'alayu', CAST(N'2022-05-25T06:05:19.880' AS DateTime), CAST(N'2022-05-25T06:05:19.880' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471405, N'alayu', CAST(N'2022-05-25T06:25:56.743' AS DateTime), CAST(N'2022-05-25T06:25:56.743' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471406, N'gech', CAST(N'2022-05-25T06:45:49.967' AS DateTime), CAST(N'2022-05-25T06:45:49.967' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471407, N'biruke', CAST(N'2022-05-25T23:32:59.560' AS DateTime), CAST(N'2022-05-25T23:32:59.560' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471408, N'alayu', CAST(N'2022-05-26T00:15:09.070' AS DateTime), CAST(N'2022-05-26T00:15:09.070' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471409, N'alayu', CAST(N'2022-05-26T02:10:44.133' AS DateTime), CAST(N'2022-05-26T02:10:44.133' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (471410, N'alayu', CAST(N'2022-05-26T04:51:49.427' AS DateTime), CAST(N'2022-05-26T04:51:49.427' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481350, N'biruke', CAST(N'2022-05-26T05:08:38.663' AS DateTime), CAST(N'2022-05-26T05:08:38.663' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481351, N'alayu', CAST(N'2022-05-26T05:27:21.070' AS DateTime), CAST(N'2022-05-26T05:27:21.070' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481352, N'gech', CAST(N'2022-05-26T05:43:36.937' AS DateTime), CAST(N'2022-05-26T05:43:36.937' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481353, N'alayu', CAST(N'2022-05-26T06:33:36.717' AS DateTime), CAST(N'2022-05-26T06:33:36.717' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481354, N'alayu', CAST(N'2022-05-26T07:12:30.853' AS DateTime), CAST(N'2022-05-26T07:12:30.853' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481355, N'alayu', CAST(N'2022-05-26T22:05:20.367' AS DateTime), CAST(N'2022-05-26T22:05:20.367' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481356, N'biruke', CAST(N'2022-05-26T22:05:27.977' AS DateTime), CAST(N'2022-05-26T22:05:27.977' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481357, N'biruke', CAST(N'2022-05-26T22:13:19.717' AS DateTime), CAST(N'2022-05-26T22:13:19.717' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481358, N'biruke', CAST(N'2022-05-26T22:28:50.933' AS DateTime), CAST(N'2022-05-26T22:28:50.933' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481359, N'biruke', CAST(N'2022-05-26T22:29:33.427' AS DateTime), CAST(N'2022-05-26T22:29:33.427' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481360, N'biruke', CAST(N'2022-05-26T22:31:13.333' AS DateTime), CAST(N'2022-05-26T22:31:13.333' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481361, N'biruke', CAST(N'2022-05-26T22:38:03.853' AS DateTime), CAST(N'2022-05-26T22:38:03.853' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481362, N'biruke', CAST(N'2022-05-26T22:41:04.970' AS DateTime), CAST(N'2022-05-26T22:41:04.970' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481363, N'biruke', CAST(N'2022-05-26T22:42:04.373' AS DateTime), CAST(N'2022-05-26T22:42:04.373' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481364, N'biruke', CAST(N'2022-05-26T22:42:17.017' AS DateTime), CAST(N'2022-05-26T22:42:17.017' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481365, N'biruke', CAST(N'2022-05-26T22:42:21.277' AS DateTime), CAST(N'2022-05-26T22:42:21.277' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481366, N'biruke', CAST(N'2022-05-26T22:42:30.577' AS DateTime), CAST(N'2022-05-26T22:42:30.577' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481367, N'biruke', CAST(N'2022-05-26T22:42:41.557' AS DateTime), CAST(N'2022-05-26T22:42:41.557' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481368, N'biruke', CAST(N'2022-05-26T22:44:49.970' AS DateTime), CAST(N'2022-05-26T22:44:49.973' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481369, N'biruke', CAST(N'2022-05-26T22:48:00.443' AS DateTime), CAST(N'2022-05-26T22:48:00.443' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481370, N'alayu', CAST(N'2022-05-26T22:48:23.940' AS DateTime), CAST(N'2022-05-26T22:48:23.940' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481371, N'alayu', CAST(N'2022-05-26T22:49:11.467' AS DateTime), CAST(N'2022-05-26T22:49:11.467' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481372, N'biruke', CAST(N'2022-05-26T22:49:22.737' AS DateTime), CAST(N'2022-05-26T22:49:22.737' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481373, N'biruke', CAST(N'2022-05-26T22:49:26.177' AS DateTime), CAST(N'2022-05-26T22:49:26.177' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481374, N'alayu', CAST(N'2022-05-26T22:53:43.107' AS DateTime), CAST(N'2022-05-26T22:53:43.107' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481375, N'biruke', CAST(N'2022-05-26T22:54:01.987' AS DateTime), CAST(N'2022-05-26T22:54:01.987' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481376, N'alayu', CAST(N'2022-05-26T22:54:52.127' AS DateTime), CAST(N'2022-05-26T22:54:52.127' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481377, N'alayu', CAST(N'2022-05-26T22:58:50.133' AS DateTime), CAST(N'2022-05-26T22:58:50.133' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481378, N'alayu', CAST(N'2022-05-26T23:02:42.363' AS DateTime), CAST(N'2022-05-26T23:02:42.363' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481379, N'alayu', CAST(N'2022-05-26T23:06:52.737' AS DateTime), CAST(N'2022-05-26T23:06:52.737' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481380, N'alayu', CAST(N'2022-05-26T23:19:42.887' AS DateTime), CAST(N'2022-05-26T23:19:42.887' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481381, N'alayu', CAST(N'2022-05-26T23:25:44.970' AS DateTime), CAST(N'2022-05-26T23:25:44.970' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481382, N'alayu', CAST(N'2022-05-26T23:40:14.403' AS DateTime), CAST(N'2022-05-26T23:40:14.403' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481383, N'alayu', CAST(N'2022-05-26T23:47:56.773' AS DateTime), CAST(N'2022-05-26T23:47:56.773' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (481384, N'biruke', CAST(N'2022-05-26T23:48:01.513' AS DateTime), CAST(N'2022-05-26T23:48:01.513' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491358, N'biruke', CAST(N'2022-05-27T00:02:15.217' AS DateTime), CAST(N'2022-05-27T00:02:15.217' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491359, N'alayu', CAST(N'2022-05-27T00:19:47.607' AS DateTime), CAST(N'2022-05-27T00:19:47.607' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491360, N'biruke', CAST(N'2022-05-27T00:19:57.833' AS DateTime), CAST(N'2022-05-27T00:19:57.833' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491361, N'biruke', CAST(N'2022-05-27T00:27:21.623' AS DateTime), CAST(N'2022-05-27T00:27:21.623' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491362, N'alayu', CAST(N'2022-05-27T00:42:47.143' AS DateTime), CAST(N'2022-05-27T00:42:47.143' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491363, N'biruke', CAST(N'2022-05-27T00:46:00.023' AS DateTime), CAST(N'2022-05-27T00:46:00.023' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491364, N'biruke', CAST(N'2022-05-27T00:48:04.693' AS DateTime), CAST(N'2022-05-27T00:48:04.693' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491365, N'alayu', CAST(N'2022-05-27T00:53:56.137' AS DateTime), CAST(N'2022-05-27T00:53:56.137' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491366, N'biruke', CAST(N'2022-05-27T00:56:35.573' AS DateTime), CAST(N'2022-05-27T00:56:35.573' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491367, N'alayu', CAST(N'2022-05-27T01:03:32.007' AS DateTime), CAST(N'2022-05-27T01:03:32.007' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491368, N'biruke', CAST(N'2022-05-27T01:03:50.327' AS DateTime), CAST(N'2022-05-27T01:03:50.327' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491369, N'biruke', CAST(N'2022-05-27T01:04:49.240' AS DateTime), CAST(N'2022-05-27T01:04:49.240' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491370, N'biruke', CAST(N'2022-05-27T01:19:16.353' AS DateTime), CAST(N'2022-05-27T01:19:16.353' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491371, N'biruke', CAST(N'2022-05-27T01:27:48.153' AS DateTime), CAST(N'2022-05-27T01:27:48.153' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491372, N'biruke', CAST(N'2022-05-27T01:29:05.643' AS DateTime), CAST(N'2022-05-27T01:29:05.643' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491373, N'biruke', CAST(N'2022-05-27T01:35:08.170' AS DateTime), CAST(N'2022-05-27T01:35:08.170' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491374, N'biruke', CAST(N'2022-05-27T01:58:10.700' AS DateTime), CAST(N'2022-05-27T01:58:10.700' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491375, N'biruke', CAST(N'2022-05-27T01:59:41.797' AS DateTime), CAST(N'2022-05-27T01:59:41.797' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491376, N'biruke', CAST(N'2022-05-27T02:00:10.737' AS DateTime), CAST(N'2022-05-27T02:00:10.737' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491377, N'biruke', CAST(N'2022-05-27T02:01:49.117' AS DateTime), CAST(N'2022-05-27T02:01:49.117' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491378, N'biruke', CAST(N'2022-05-27T03:07:41.643' AS DateTime), CAST(N'2022-05-27T03:07:41.643' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491379, N'biruke', CAST(N'2022-05-27T03:13:10.527' AS DateTime), CAST(N'2022-05-27T03:13:10.527' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491380, N'biruke', CAST(N'2022-05-27T03:13:40.153' AS DateTime), CAST(N'2022-05-27T03:13:40.153' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491381, N'biruke', CAST(N'2022-05-27T03:22:43.503' AS DateTime), CAST(N'2022-05-27T03:22:43.503' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491382, N'biruke', CAST(N'2022-05-27T03:23:32.743' AS DateTime), CAST(N'2022-05-27T03:23:32.743' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491383, N'biruke', CAST(N'2022-05-27T03:31:41.250' AS DateTime), CAST(N'2022-05-27T03:31:41.250' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491384, N'biruke', CAST(N'2022-05-27T03:37:14.463' AS DateTime), CAST(N'2022-05-27T03:37:14.463' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491385, N'biruke', CAST(N'2022-05-27T03:37:43.477' AS DateTime), CAST(N'2022-05-27T03:37:43.477' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491386, N'biruke', CAST(N'2022-05-27T03:39:19.103' AS DateTime), CAST(N'2022-05-27T03:39:19.103' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (491387, N'biruke', CAST(N'2022-05-27T03:40:58.483' AS DateTime), CAST(N'2022-05-27T03:40:58.483' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501365, N'biruke', CAST(N'2022-05-27T03:58:23.310' AS DateTime), CAST(N'2022-05-27T03:58:23.310' AS DateTime), N'I', N'')
GO
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501366, N'biruke', CAST(N'2022-05-27T04:06:34.097' AS DateTime), CAST(N'2022-05-27T04:06:34.097' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501367, N'biruke', CAST(N'2022-05-27T04:37:10.080' AS DateTime), CAST(N'2022-05-27T04:37:10.080' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501368, N'biruke', CAST(N'2022-05-27T04:48:27.357' AS DateTime), CAST(N'2022-05-27T04:48:27.357' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501369, N'biruke', CAST(N'2022-05-27T04:57:17.723' AS DateTime), CAST(N'2022-05-27T04:57:17.723' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501370, N'biruke', CAST(N'2022-05-27T05:12:43.840' AS DateTime), CAST(N'2022-05-27T05:12:43.840' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501371, N'biruke', CAST(N'2022-05-27T05:14:10.450' AS DateTime), CAST(N'2022-05-27T05:14:10.450' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501372, N'biruke', CAST(N'2022-05-27T05:19:51.923' AS DateTime), CAST(N'2022-05-27T05:19:51.923' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501373, N'biruke', CAST(N'2022-05-27T05:21:45.770' AS DateTime), CAST(N'2022-05-27T05:21:45.770' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501374, N'biruke', CAST(N'2022-05-27T05:28:07.597' AS DateTime), CAST(N'2022-05-27T05:28:07.597' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501375, N'biruke', CAST(N'2022-05-27T05:30:09.657' AS DateTime), CAST(N'2022-05-27T05:30:09.657' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501376, N'biruke', CAST(N'2022-05-27T05:31:08.593' AS DateTime), CAST(N'2022-05-27T05:31:08.593' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501377, N'alayu', CAST(N'2022-05-27T05:33:56.120' AS DateTime), CAST(N'2022-05-27T05:33:56.120' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501378, N'biruke', CAST(N'2022-05-27T05:34:06.733' AS DateTime), CAST(N'2022-05-27T05:34:06.733' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501379, N'alayu', CAST(N'2022-05-27T05:34:27.943' AS DateTime), CAST(N'2022-05-27T05:34:27.943' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501380, N'alayu', CAST(N'2022-05-27T05:38:38.600' AS DateTime), CAST(N'2022-05-27T05:38:38.600' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501381, N'alayu', CAST(N'2022-05-27T06:05:40.297' AS DateTime), CAST(N'2022-05-27T06:05:40.297' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501382, N'alayu', CAST(N'2022-05-27T06:07:52.970' AS DateTime), CAST(N'2022-05-27T06:07:52.970' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501383, N'alayu', CAST(N'2022-05-27T06:22:30.813' AS DateTime), CAST(N'2022-05-27T06:22:30.813' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501384, N'alayu', CAST(N'2022-05-27T06:31:35.647' AS DateTime), CAST(N'2022-05-27T06:31:35.647' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501385, N'alayu', CAST(N'2022-05-27T06:56:23.473' AS DateTime), CAST(N'2022-05-27T06:56:23.473' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501386, N'biruke', CAST(N'2022-05-27T06:58:42.620' AS DateTime), CAST(N'2022-05-27T06:58:42.620' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501387, N'biruke', CAST(N'2022-05-27T06:59:47.430' AS DateTime), CAST(N'2022-05-27T06:59:47.430' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501388, N'gech', CAST(N'2022-05-27T07:00:41.390' AS DateTime), CAST(N'2022-05-27T07:00:41.390' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501389, N'biruke', CAST(N'2022-05-27T07:10:14.283' AS DateTime), CAST(N'2022-05-27T07:10:14.283' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501390, N'alayu', CAST(N'2022-05-27T07:11:04.090' AS DateTime), CAST(N'2022-05-27T07:11:04.090' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501391, N'alayu', CAST(N'2022-05-27T07:11:09.513' AS DateTime), CAST(N'2022-05-27T07:11:09.513' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501392, N'biruke', CAST(N'2022-05-27T07:11:15.527' AS DateTime), CAST(N'2022-05-27T07:11:15.527' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501393, N'biruke', CAST(N'2022-05-27T07:17:31.973' AS DateTime), CAST(N'2022-05-27T07:17:31.973' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501394, N'biruke', CAST(N'2022-05-27T07:28:03.153' AS DateTime), CAST(N'2022-05-27T07:28:03.153' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501395, N'biruke', CAST(N'2022-05-27T07:32:12.653' AS DateTime), CAST(N'2022-05-27T07:32:12.653' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501396, N'biruke', CAST(N'2022-05-27T07:32:19.100' AS DateTime), CAST(N'2022-05-27T07:32:19.100' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501397, N'biruke', CAST(N'2022-05-29T22:39:50.317' AS DateTime), CAST(N'2022-05-29T22:39:50.317' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501398, N'biruke', CAST(N'2022-05-30T03:24:57.307' AS DateTime), CAST(N'2022-05-30T03:24:57.310' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501399, N'biruke', CAST(N'2022-05-30T05:00:32.217' AS DateTime), CAST(N'2022-05-30T05:00:32.217' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501400, N'biruke', CAST(N'2022-05-30T22:14:27.570' AS DateTime), CAST(N'2022-05-30T22:14:27.570' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501401, N'biruke', CAST(N'2022-05-31T22:16:06.527' AS DateTime), CAST(N'2022-05-31T22:16:06.527' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501402, N'biruke', CAST(N'2022-05-31T22:27:45.357' AS DateTime), CAST(N'2022-05-31T22:27:45.357' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501403, N'biruke', CAST(N'2022-06-01T06:30:30.360' AS DateTime), CAST(N'2022-06-01T06:30:30.360' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (501404, N'biruke', CAST(N'2022-06-01T22:21:30.453' AS DateTime), CAST(N'2022-06-01T22:21:30.453' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511404, N'biruke', CAST(N'2022-06-02T22:16:39.330' AS DateTime), CAST(N'2022-06-02T22:16:39.330' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511405, N'biruke', CAST(N'2022-06-03T00:07:16.163' AS DateTime), CAST(N'2022-06-03T00:07:16.163' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511406, N'biruke', CAST(N'2022-06-04T00:12:40.773' AS DateTime), CAST(N'2022-06-04T00:12:40.773' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511407, N'biruke', CAST(N'2022-06-04T02:27:30.043' AS DateTime), CAST(N'2022-06-04T02:27:30.043' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511408, N'biruke', CAST(N'2022-06-05T23:36:38.383' AS DateTime), CAST(N'2022-06-05T23:36:38.383' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511409, N'biruke', CAST(N'2022-06-06T23:36:57.480' AS DateTime), CAST(N'2022-06-06T23:36:57.480' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511410, N'biruke', CAST(N'2022-06-07T22:58:24.400' AS DateTime), CAST(N'2022-06-07T22:58:24.400' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511411, N'biruke', CAST(N'2022-06-09T00:44:14.210' AS DateTime), CAST(N'2022-06-09T00:44:14.210' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511412, N'biruke', CAST(N'2022-06-09T01:13:27.030' AS DateTime), CAST(N'2022-06-09T01:13:27.030' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511413, N'biruke', CAST(N'2022-06-09T03:37:21.277' AS DateTime), CAST(N'2022-06-09T03:37:21.277' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511414, N'biruke', CAST(N'2022-06-09T04:15:26.770' AS DateTime), CAST(N'2022-06-09T04:15:26.770' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511415, N'biruke', CAST(N'2022-06-09T04:17:28.673' AS DateTime), CAST(N'2022-06-09T04:17:28.673' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511416, N'biruke', CAST(N'2022-06-09T04:18:13.540' AS DateTime), CAST(N'2022-06-09T04:18:13.540' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511417, N'biruke', CAST(N'2022-06-09T04:18:49.660' AS DateTime), CAST(N'2022-06-09T04:18:49.660' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511418, N'biruke', CAST(N'2022-06-09T04:19:25.237' AS DateTime), CAST(N'2022-06-09T04:19:25.237' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511419, N'biruke', CAST(N'2022-06-09T04:20:29.183' AS DateTime), CAST(N'2022-06-09T04:20:29.183' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511420, N'biruke', CAST(N'2022-06-09T04:25:27.057' AS DateTime), CAST(N'2022-06-09T04:25:27.057' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511421, N'biruke', CAST(N'2022-06-09T04:25:41.320' AS DateTime), CAST(N'2022-06-09T04:25:41.320' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511422, N'biruke', CAST(N'2022-06-09T04:26:53.657' AS DateTime), CAST(N'2022-06-09T04:26:53.657' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511423, N'biruke', CAST(N'2022-06-09T04:28:37.097' AS DateTime), CAST(N'2022-06-09T04:28:37.097' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511424, N'biruke', CAST(N'2022-06-09T04:29:53.023' AS DateTime), CAST(N'2022-06-09T04:29:53.023' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511425, N'biruke', CAST(N'2022-06-09T04:30:27.243' AS DateTime), CAST(N'2022-06-09T04:30:27.243' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511426, N'biruke', CAST(N'2022-06-09T04:31:16.070' AS DateTime), CAST(N'2022-06-09T04:31:16.070' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511427, N'biruke', CAST(N'2022-06-09T04:33:08.733' AS DateTime), CAST(N'2022-06-09T04:33:08.733' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511428, N'biruke', CAST(N'2022-06-09T04:33:35.350' AS DateTime), CAST(N'2022-06-09T04:33:35.350' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511429, N'biruke', CAST(N'2022-06-09T04:33:47.143' AS DateTime), CAST(N'2022-06-09T04:33:47.143' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511430, N'biruke', CAST(N'2022-06-09T04:35:19.607' AS DateTime), CAST(N'2022-06-09T04:35:19.607' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511431, N'biruke', CAST(N'2022-06-09T04:40:03.670' AS DateTime), CAST(N'2022-06-09T04:40:03.670' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511432, N'biruke', CAST(N'2022-06-09T04:42:17.617' AS DateTime), CAST(N'2022-06-09T04:42:17.617' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511433, N'biruke', CAST(N'2022-06-09T04:43:22.977' AS DateTime), CAST(N'2022-06-09T04:43:22.977' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511434, N'biruke', CAST(N'2022-06-09T04:44:41.650' AS DateTime), CAST(N'2022-06-09T04:44:41.650' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511435, N'biruke', CAST(N'2022-06-09T04:47:11.557' AS DateTime), CAST(N'2022-06-09T04:47:11.557' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511436, N'biruke', CAST(N'2022-06-09T04:54:17.970' AS DateTime), CAST(N'2022-06-09T04:54:17.970' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511437, N'biruke', CAST(N'2022-06-09T04:56:05.873' AS DateTime), CAST(N'2022-06-09T04:56:05.873' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511438, N'biruke', CAST(N'2022-06-09T04:57:45.330' AS DateTime), CAST(N'2022-06-09T04:57:45.330' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511439, N'biruke', CAST(N'2022-06-09T05:00:03.697' AS DateTime), CAST(N'2022-06-09T05:00:03.697' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511440, N'biruke', CAST(N'2022-06-09T05:00:43.423' AS DateTime), CAST(N'2022-06-09T05:00:43.423' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511441, N'biruke', CAST(N'2022-06-09T05:01:47.863' AS DateTime), CAST(N'2022-06-09T05:01:47.863' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511442, N'biruke', CAST(N'2022-06-09T05:02:55.777' AS DateTime), CAST(N'2022-06-09T05:02:55.777' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511443, N'biruke', CAST(N'2022-06-09T05:03:55.077' AS DateTime), CAST(N'2022-06-09T05:03:55.077' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511444, N'biruke', CAST(N'2022-06-09T05:04:55.087' AS DateTime), CAST(N'2022-06-09T05:04:55.087' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511445, N'biruke', CAST(N'2022-06-09T05:05:42.747' AS DateTime), CAST(N'2022-06-09T05:05:42.747' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511446, N'biruke', CAST(N'2022-06-09T05:06:18.957' AS DateTime), CAST(N'2022-06-09T05:06:18.957' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511447, N'biruke', CAST(N'2022-06-09T05:07:39.610' AS DateTime), CAST(N'2022-06-09T05:07:39.610' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511448, N'biruke', CAST(N'2022-06-09T05:08:17.363' AS DateTime), CAST(N'2022-06-09T05:08:17.363' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511449, N'biruke', CAST(N'2022-06-09T05:08:47.877' AS DateTime), CAST(N'2022-06-09T05:08:47.877' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511450, N'biruke', CAST(N'2022-06-09T05:09:58.040' AS DateTime), CAST(N'2022-06-09T05:09:58.040' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511451, N'biruke', CAST(N'2022-06-09T05:13:28.787' AS DateTime), CAST(N'2022-06-09T05:13:28.787' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511452, N'biruke', CAST(N'2022-06-09T05:30:04.787' AS DateTime), CAST(N'2022-06-09T05:30:04.787' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511453, N'biruke', CAST(N'2022-06-09T05:39:35.007' AS DateTime), CAST(N'2022-06-09T05:39:35.007' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511454, N'biruke', CAST(N'2022-06-09T05:39:44.517' AS DateTime), CAST(N'2022-06-09T05:39:44.517' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511455, N'biruke', CAST(N'2022-06-09T05:52:12.940' AS DateTime), CAST(N'2022-06-09T05:52:12.940' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511456, N'biruke', CAST(N'2022-06-09T05:53:24.083' AS DateTime), CAST(N'2022-06-09T05:53:24.083' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511457, N'biruke', CAST(N'2022-06-09T06:00:57.180' AS DateTime), CAST(N'2022-06-09T06:00:57.180' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511458, N'biruke', CAST(N'2022-06-09T06:06:40.800' AS DateTime), CAST(N'2022-06-09T06:06:40.800' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511459, N'biruke', CAST(N'2022-06-09T06:08:59.553' AS DateTime), CAST(N'2022-06-09T06:08:59.553' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511460, N'biruke', CAST(N'2022-06-09T06:10:47.977' AS DateTime), CAST(N'2022-06-09T06:10:47.980' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511461, N'biruke', CAST(N'2022-06-09T06:11:59.377' AS DateTime), CAST(N'2022-06-09T06:11:59.377' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511462, N'biruke', CAST(N'2022-06-09T06:17:28.017' AS DateTime), CAST(N'2022-06-09T06:17:28.017' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511463, N'biruke', CAST(N'2022-06-09T06:19:08.823' AS DateTime), CAST(N'2022-06-09T06:19:08.827' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511464, N'biruke', CAST(N'2022-06-09T06:22:05.663' AS DateTime), CAST(N'2022-06-09T06:22:05.663' AS DateTime), N'I', N'')
GO
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511465, N'biruke', CAST(N'2022-06-09T21:37:08.103' AS DateTime), CAST(N'2022-06-09T21:37:08.103' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511466, N'biruke', CAST(N'2022-06-09T21:48:58.890' AS DateTime), CAST(N'2022-06-09T21:48:58.890' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511467, N'biruke', CAST(N'2022-06-09T22:09:23.803' AS DateTime), CAST(N'2022-06-09T22:09:23.803' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511468, N'biruke', CAST(N'2022-06-10T23:55:57.960' AS DateTime), CAST(N'2022-06-10T23:55:57.960' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511469, N'biruke', CAST(N'2022-06-11T00:04:49.150' AS DateTime), CAST(N'2022-06-11T00:04:49.153' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511470, N'biruke', CAST(N'2022-06-11T00:16:34.533' AS DateTime), CAST(N'2022-06-11T00:16:34.533' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511471, N'biruke', CAST(N'2022-06-11T00:35:56.793' AS DateTime), CAST(N'2022-06-11T00:35:56.793' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511472, N'biruke', CAST(N'2022-06-11T00:39:55.473' AS DateTime), CAST(N'2022-06-11T00:39:55.473' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511473, N'biruke', CAST(N'2022-06-11T00:45:16.673' AS DateTime), CAST(N'2022-06-11T00:45:16.673' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511474, N'biruke', CAST(N'2022-06-11T01:03:39.477' AS DateTime), CAST(N'2022-06-11T01:03:39.477' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511475, N'biruke', CAST(N'2022-06-11T01:05:58.223' AS DateTime), CAST(N'2022-06-11T01:05:58.223' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511476, N'biruke', CAST(N'2022-06-11T01:09:42.687' AS DateTime), CAST(N'2022-06-11T01:09:42.690' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511477, N'biruke', CAST(N'2022-06-11T01:13:31.787' AS DateTime), CAST(N'2022-06-11T01:13:31.787' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511478, N'biruke', CAST(N'2022-06-11T01:22:55.047' AS DateTime), CAST(N'2022-06-11T01:22:55.047' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511479, N'biruke', CAST(N'2022-06-11T01:36:43.090' AS DateTime), CAST(N'2022-06-11T01:36:43.090' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511480, N'biruke', CAST(N'2022-06-11T01:41:49.947' AS DateTime), CAST(N'2022-06-11T01:41:49.947' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511481, N'biruke', CAST(N'2022-06-11T01:47:38.310' AS DateTime), CAST(N'2022-06-11T01:47:38.310' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511482, N'biruke', CAST(N'2022-06-11T01:54:44.433' AS DateTime), CAST(N'2022-06-11T01:54:44.433' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511483, N'biruke', CAST(N'2022-06-11T01:57:22.730' AS DateTime), CAST(N'2022-06-11T01:57:22.730' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511484, N'biruke', CAST(N'2022-06-11T02:07:27.093' AS DateTime), CAST(N'2022-06-11T02:07:27.093' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511485, N'biruke', CAST(N'2022-06-11T02:11:16.860' AS DateTime), CAST(N'2022-06-11T02:11:16.863' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511486, N'biruke', CAST(N'2022-06-11T02:14:14.043' AS DateTime), CAST(N'2022-06-11T02:14:14.043' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511487, N'biruke', CAST(N'2022-06-11T02:16:57.057' AS DateTime), CAST(N'2022-06-11T02:16:57.060' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511488, N'biruke', CAST(N'2022-06-11T02:21:03.907' AS DateTime), CAST(N'2022-06-11T02:21:03.907' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511489, N'biruke', CAST(N'2022-06-11T02:27:42.137' AS DateTime), CAST(N'2022-06-11T02:27:42.137' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511490, N'biruke', CAST(N'2022-06-11T02:32:23.007' AS DateTime), CAST(N'2022-06-11T02:32:23.007' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511491, N'biruke', CAST(N'2022-06-11T02:33:56.007' AS DateTime), CAST(N'2022-06-11T02:33:56.007' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511492, N'biruke', CAST(N'2022-06-11T02:37:01.630' AS DateTime), CAST(N'2022-06-11T02:37:01.630' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511493, N'biruke', CAST(N'2022-06-11T02:57:41.987' AS DateTime), CAST(N'2022-06-11T02:57:41.987' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511494, N'biruke', CAST(N'2022-06-11T03:12:44.093' AS DateTime), CAST(N'2022-06-11T03:12:44.093' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511495, N'biruke', CAST(N'2022-06-11T03:28:15.370' AS DateTime), CAST(N'2022-06-11T03:28:15.370' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511496, N'biruke', CAST(N'2022-06-11T03:48:52.540' AS DateTime), CAST(N'2022-06-11T03:48:52.540' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511497, N'biruke', CAST(N'2022-06-11T04:08:46.520' AS DateTime), CAST(N'2022-06-11T04:08:46.520' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511498, N'biruke', CAST(N'2022-06-11T04:21:55.437' AS DateTime), CAST(N'2022-06-11T04:21:55.437' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511499, N'biruke', CAST(N'2022-06-12T22:21:21.700' AS DateTime), CAST(N'2022-06-12T22:21:21.703' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511500, N'biruke', CAST(N'2022-06-13T00:36:44.697' AS DateTime), CAST(N'2022-06-13T00:36:44.697' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511501, N'biruke', CAST(N'2022-06-13T00:44:03.493' AS DateTime), CAST(N'2022-06-13T00:44:03.493' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511502, N'biruke', CAST(N'2022-06-13T00:46:16.213' AS DateTime), CAST(N'2022-06-13T00:46:16.213' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511503, N'alayu', CAST(N'2022-06-13T00:46:37.273' AS DateTime), CAST(N'2022-06-13T00:46:37.273' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (511504, N'gech', CAST(N'2022-06-13T00:55:29.687' AS DateTime), CAST(N'2022-06-13T00:55:29.687' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (521499, N'biruke', CAST(N'2022-06-13T04:29:05.073' AS DateTime), CAST(N'2022-06-13T04:29:05.073' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (521500, N'biruke', CAST(N'2022-06-13T05:00:24.247' AS DateTime), CAST(N'2022-06-13T05:00:24.247' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (521501, N'biruke', CAST(N'2022-06-14T23:17:04.220' AS DateTime), CAST(N'2022-06-14T23:17:04.220' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (521502, N'biruke', CAST(N'2022-06-14T23:20:16.493' AS DateTime), CAST(N'2022-06-14T23:20:16.493' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531501, N'biruke', CAST(N'2022-06-14T23:41:09.913' AS DateTime), CAST(N'2022-06-14T23:41:09.913' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531502, N'biruke', CAST(N'2022-06-15T00:15:32.390' AS DateTime), CAST(N'2022-06-15T00:15:32.390' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531503, N'biruke', CAST(N'2022-06-15T04:12:59.937' AS DateTime), CAST(N'2022-06-15T04:12:59.937' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531504, N'biruke', CAST(N'2022-06-15T23:31:14.193' AS DateTime), CAST(N'2022-06-15T23:31:14.193' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531505, N'biruke', CAST(N'2022-06-16T00:39:08.183' AS DateTime), CAST(N'2022-06-16T00:39:08.183' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531506, N'biruke', CAST(N'2022-06-16T03:39:48.753' AS DateTime), CAST(N'2022-06-16T03:39:48.753' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531507, N'biruke', CAST(N'2022-06-16T04:43:09.963' AS DateTime), CAST(N'2022-06-16T04:43:09.963' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531508, N'biruke', CAST(N'2022-06-16T23:29:09.047' AS DateTime), CAST(N'2022-06-16T23:29:09.047' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531509, N'biruke', CAST(N'2022-06-16T23:49:06.523' AS DateTime), CAST(N'2022-06-16T23:49:06.523' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531510, N'biruke', CAST(N'2022-06-17T00:12:09.780' AS DateTime), CAST(N'2022-06-17T00:12:09.780' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531511, N'biruke', CAST(N'2022-06-17T22:32:36.727' AS DateTime), CAST(N'2022-06-17T22:32:36.727' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531512, N'biruke', CAST(N'2022-06-18T04:14:05.613' AS DateTime), CAST(N'2022-06-18T04:14:05.613' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531513, N'alayu', CAST(N'2022-06-18T04:14:47.353' AS DateTime), CAST(N'2022-06-18T04:14:47.353' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531514, N'biruke', CAST(N'2022-06-19T21:27:59.220' AS DateTime), CAST(N'2022-06-19T21:27:59.220' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531515, N'biruke', CAST(N'2022-06-21T02:44:42.477' AS DateTime), CAST(N'2022-06-21T02:44:42.477' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531516, N'biruke', CAST(N'2022-06-21T03:47:39.967' AS DateTime), CAST(N'2022-06-21T03:47:39.967' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531517, N'alayu', CAST(N'2022-06-21T03:54:16.080' AS DateTime), CAST(N'2022-06-21T03:54:16.080' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531518, N'alayu', CAST(N'2022-06-21T04:02:55.597' AS DateTime), CAST(N'2022-06-21T04:02:55.597' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531519, N'biruke', CAST(N'2022-06-21T04:46:32.310' AS DateTime), CAST(N'2022-06-21T04:46:32.310' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531520, N'biruke', CAST(N'2022-06-21T05:09:39.683' AS DateTime), CAST(N'2022-06-21T05:09:39.687' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531521, N'biruke', CAST(N'2022-06-21T05:10:14.097' AS DateTime), CAST(N'2022-06-21T05:10:14.097' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531522, N'biruke', CAST(N'2022-06-21T05:11:20.843' AS DateTime), CAST(N'2022-06-21T05:11:20.843' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531523, N'biruke', CAST(N'2022-06-21T05:21:25.723' AS DateTime), CAST(N'2022-06-21T05:21:25.723' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531524, N'biruke', CAST(N'2022-06-22T22:46:12.333' AS DateTime), CAST(N'2022-06-22T22:46:12.337' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531525, N'biruke', CAST(N'2022-06-22T22:49:03.490' AS DateTime), CAST(N'2022-06-22T22:49:03.493' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531526, N'biruke', CAST(N'2022-06-22T23:25:08.223' AS DateTime), CAST(N'2022-06-22T23:25:08.223' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531527, N'biruke', CAST(N'2022-06-22T23:26:35.813' AS DateTime), CAST(N'2022-06-22T23:26:35.813' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531528, N'biruke', CAST(N'2022-06-22T23:30:50.187' AS DateTime), CAST(N'2022-06-22T23:30:50.187' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531529, N'biruke', CAST(N'2022-06-22T23:34:04.907' AS DateTime), CAST(N'2022-06-22T23:34:04.907' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531530, N'biruke', CAST(N'2022-06-23T00:04:43.600' AS DateTime), CAST(N'2022-06-23T00:04:43.600' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531531, N'biruke', CAST(N'2022-06-23T00:10:48.360' AS DateTime), CAST(N'2022-06-23T00:10:48.360' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531532, N'biruke', CAST(N'2022-06-23T00:11:49.597' AS DateTime), CAST(N'2022-06-23T00:11:49.597' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531533, N'biruke', CAST(N'2022-06-23T00:26:29.500' AS DateTime), CAST(N'2022-06-23T00:26:29.500' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531534, N'biruke', CAST(N'2022-06-23T00:28:13.977' AS DateTime), CAST(N'2022-06-23T00:28:13.977' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531535, N'biruke', CAST(N'2022-06-23T00:51:39.337' AS DateTime), CAST(N'2022-06-23T00:51:39.337' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531536, N'biruke', CAST(N'2022-06-23T01:12:00.253' AS DateTime), CAST(N'2022-06-23T01:12:00.253' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531537, N'biruke', CAST(N'2022-06-23T01:13:25.473' AS DateTime), CAST(N'2022-06-23T01:13:25.473' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531538, N'biruke', CAST(N'2022-06-23T01:14:10.937' AS DateTime), CAST(N'2022-06-23T01:14:10.940' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531539, N'biruke', CAST(N'2022-06-23T01:16:19.693' AS DateTime), CAST(N'2022-06-23T01:16:19.693' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531540, N'biruke', CAST(N'2022-06-23T01:21:23.430' AS DateTime), CAST(N'2022-06-23T01:21:23.430' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531541, N'biruke', CAST(N'2022-06-23T01:23:19.670' AS DateTime), CAST(N'2022-06-23T01:23:19.670' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531542, N'biruke', CAST(N'2022-06-23T01:27:32.163' AS DateTime), CAST(N'2022-06-23T01:27:32.163' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531543, N'biruke', CAST(N'2022-06-23T01:29:10.283' AS DateTime), CAST(N'2022-06-23T01:29:10.283' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531544, N'biruke', CAST(N'2022-06-23T01:30:49.277' AS DateTime), CAST(N'2022-06-23T01:30:49.277' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531545, N'biruke', CAST(N'2022-06-23T01:33:19.890' AS DateTime), CAST(N'2022-06-23T01:33:19.890' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531546, N'biruke', CAST(N'2022-06-23T01:39:25.460' AS DateTime), CAST(N'2022-06-23T01:39:25.460' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531547, N'biruke', CAST(N'2022-06-23T01:41:45.533' AS DateTime), CAST(N'2022-06-23T01:41:45.533' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531548, N'biruke', CAST(N'2022-06-23T01:49:31.143' AS DateTime), CAST(N'2022-06-23T01:49:31.143' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531549, N'biruke', CAST(N'2022-06-23T01:51:48.913' AS DateTime), CAST(N'2022-06-23T01:51:48.913' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531550, N'biruke', CAST(N'2022-06-23T01:53:41.970' AS DateTime), CAST(N'2022-06-23T01:53:41.973' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531551, N'biruke', CAST(N'2022-06-23T01:54:59.753' AS DateTime), CAST(N'2022-06-23T01:54:59.753' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531552, N'biruke', CAST(N'2022-06-23T01:56:13.047' AS DateTime), CAST(N'2022-06-23T01:56:13.047' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531553, N'biruke', CAST(N'2022-06-23T01:57:30.440' AS DateTime), CAST(N'2022-06-23T01:57:30.440' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531554, N'biruke', CAST(N'2022-06-23T01:59:37.420' AS DateTime), CAST(N'2022-06-23T01:59:37.420' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531555, N'biruke', CAST(N'2022-06-23T02:01:18.170' AS DateTime), CAST(N'2022-06-23T02:01:18.170' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531556, N'biruke', CAST(N'2022-06-23T02:03:09.927' AS DateTime), CAST(N'2022-06-23T02:03:09.927' AS DateTime), N'I', N'')
GO
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531557, N'biruke', CAST(N'2022-06-23T02:05:48.510' AS DateTime), CAST(N'2022-06-23T02:05:48.510' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531558, N'biruke', CAST(N'2022-06-23T02:06:46.123' AS DateTime), CAST(N'2022-06-23T02:06:46.127' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531559, N'biruke', CAST(N'2022-06-23T02:08:07.470' AS DateTime), CAST(N'2022-06-23T02:08:07.470' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531560, N'biruke', CAST(N'2022-06-23T02:09:49.110' AS DateTime), CAST(N'2022-06-23T02:09:49.110' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531561, N'biruke', CAST(N'2022-06-23T03:55:15.157' AS DateTime), CAST(N'2022-06-23T03:55:15.157' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531562, N'biruke', CAST(N'2022-06-23T03:55:52.167' AS DateTime), CAST(N'2022-06-23T03:55:52.167' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531563, N'biruke', CAST(N'2022-06-23T04:00:16.723' AS DateTime), CAST(N'2022-06-23T04:00:16.723' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531564, N'biruke', CAST(N'2022-06-23T04:03:07.577' AS DateTime), CAST(N'2022-06-23T04:03:07.577' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531565, N'biruke', CAST(N'2022-06-23T04:04:02.787' AS DateTime), CAST(N'2022-06-23T04:04:02.790' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531566, N'biruke', CAST(N'2022-06-23T04:09:38.600' AS DateTime), CAST(N'2022-06-23T04:09:38.600' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531567, N'biruke', CAST(N'2022-06-23T04:10:13.107' AS DateTime), CAST(N'2022-06-23T04:10:13.107' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531568, N'biruke', CAST(N'2022-06-23T04:25:44.870' AS DateTime), CAST(N'2022-06-23T04:25:44.870' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531569, N'biruke', CAST(N'2022-06-23T04:39:49.683' AS DateTime), CAST(N'2022-06-23T04:39:49.683' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531570, N'gech', CAST(N'2022-06-23T04:41:10.447' AS DateTime), CAST(N'2022-06-23T04:41:10.447' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531571, N'alayu', CAST(N'2022-06-23T04:41:35.900' AS DateTime), CAST(N'2022-06-23T04:41:35.900' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531572, N'alayu', CAST(N'2022-06-23T04:41:59.660' AS DateTime), CAST(N'2022-06-23T04:41:59.660' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531573, N'alayu', CAST(N'2022-06-23T04:46:20.743' AS DateTime), CAST(N'2022-06-23T04:46:20.743' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531574, N'alayu', CAST(N'2022-06-23T04:50:18.943' AS DateTime), CAST(N'2022-06-23T04:50:18.943' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531575, N'alayu', CAST(N'2022-06-23T04:52:23.930' AS DateTime), CAST(N'2022-06-23T04:52:23.930' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531576, N'alayu', CAST(N'2022-06-23T04:59:10.660' AS DateTime), CAST(N'2022-06-23T04:59:10.660' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531577, N'alayu', CAST(N'2022-06-23T05:02:22.097' AS DateTime), CAST(N'2022-06-23T05:02:22.097' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531578, N'alayu', CAST(N'2022-06-23T05:05:12.993' AS DateTime), CAST(N'2022-06-23T05:05:12.993' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531579, N'alayu', CAST(N'2022-06-23T05:08:27.273' AS DateTime), CAST(N'2022-06-23T05:08:27.273' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531580, N'alayu', CAST(N'2022-06-23T05:20:00.710' AS DateTime), CAST(N'2022-06-23T05:20:00.710' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531581, N'alayu', CAST(N'2022-06-23T05:24:50.583' AS DateTime), CAST(N'2022-06-23T05:24:50.583' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531582, N'biruke', CAST(N'2022-06-23T05:27:46.153' AS DateTime), CAST(N'2022-06-23T05:27:46.153' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531583, N'alayu', CAST(N'2022-06-23T05:29:03.763' AS DateTime), CAST(N'2022-06-23T05:29:03.763' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531584, N'alayu', CAST(N'2022-06-23T06:03:32.403' AS DateTime), CAST(N'2022-06-23T06:03:32.403' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531585, N'alayu', CAST(N'2022-06-23T22:33:23.660' AS DateTime), CAST(N'2022-06-23T22:33:23.660' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531586, N'alayu', CAST(N'2022-06-24T01:19:57.677' AS DateTime), CAST(N'2022-06-24T01:19:57.677' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531587, N'alayu', CAST(N'2022-06-24T03:25:59.537' AS DateTime), CAST(N'2022-06-24T03:25:59.537' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531588, N'biruke', CAST(N'2022-06-24T03:26:34.170' AS DateTime), CAST(N'2022-06-24T03:26:34.170' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531589, N'alayu', CAST(N'2022-06-24T03:28:59.993' AS DateTime), CAST(N'2022-06-24T03:28:59.993' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531590, N'alayu', CAST(N'2022-06-24T03:53:41.853' AS DateTime), CAST(N'2022-06-24T03:53:41.853' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531591, N'alayu', CAST(N'2022-06-24T03:54:36.053' AS DateTime), CAST(N'2022-06-24T03:54:36.053' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531592, N'alayu', CAST(N'2022-06-24T03:56:51.507' AS DateTime), CAST(N'2022-06-24T03:56:51.507' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531593, N'alayu', CAST(N'2022-06-24T03:58:03.587' AS DateTime), CAST(N'2022-06-24T03:58:03.587' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531594, N'alayu', CAST(N'2022-06-24T03:59:12.743' AS DateTime), CAST(N'2022-06-24T03:59:12.743' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531595, N'alayu', CAST(N'2022-06-24T04:00:59.303' AS DateTime), CAST(N'2022-06-24T04:00:59.303' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531596, N'alayu', CAST(N'2022-06-24T04:01:21.450' AS DateTime), CAST(N'2022-06-24T04:01:21.450' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531597, N'alayu', CAST(N'2022-06-24T04:08:48.983' AS DateTime), CAST(N'2022-06-24T04:08:48.983' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531598, N'alayu', CAST(N'2022-06-24T04:11:27.243' AS DateTime), CAST(N'2022-06-24T04:11:27.243' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531599, N'alayu', CAST(N'2022-06-24T04:11:51.373' AS DateTime), CAST(N'2022-06-24T04:11:51.373' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531600, N'alayu', CAST(N'2022-06-24T04:13:14.757' AS DateTime), CAST(N'2022-06-24T04:13:14.757' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531601, N'biruke', CAST(N'2022-06-24T04:14:58.983' AS DateTime), CAST(N'2022-06-24T04:14:58.983' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531602, N'alayu', CAST(N'2022-06-24T04:15:28.963' AS DateTime), CAST(N'2022-06-24T04:15:28.963' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531603, N'alayu', CAST(N'2022-06-24T04:16:45.473' AS DateTime), CAST(N'2022-06-24T04:16:45.473' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531604, N'alayu', CAST(N'2022-06-24T04:19:37.820' AS DateTime), CAST(N'2022-06-24T04:19:37.820' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531605, N'alayu', CAST(N'2022-06-24T04:22:13.053' AS DateTime), CAST(N'2022-06-24T04:22:13.053' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531606, N'alayu', CAST(N'2022-06-24T04:25:38.910' AS DateTime), CAST(N'2022-06-24T04:25:38.910' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531607, N'alayu', CAST(N'2022-06-24T04:27:28.210' AS DateTime), CAST(N'2022-06-24T04:27:28.210' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531608, N'alayu', CAST(N'2022-06-24T04:48:13.580' AS DateTime), CAST(N'2022-06-24T04:48:13.580' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531609, N'alayu', CAST(N'2022-06-24T05:11:47.170' AS DateTime), CAST(N'2022-06-24T05:11:47.170' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531610, N'alayu', CAST(N'2022-06-25T00:14:18.647' AS DateTime), CAST(N'2022-06-25T00:14:18.647' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531611, N'alayu', CAST(N'2022-06-27T21:48:14.810' AS DateTime), CAST(N'2022-06-27T21:48:14.810' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531612, N'alayu', CAST(N'2022-06-29T04:15:08.230' AS DateTime), CAST(N'2022-06-29T04:15:08.230' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (531613, N'alayu', CAST(N'2022-06-29T04:45:40.877' AS DateTime), CAST(N'2022-06-29T04:45:40.877' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (541612, N'biruke', CAST(N'2022-07-04T22:32:54.370' AS DateTime), CAST(N'2022-07-04T22:32:54.370' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (541613, N'alayu', CAST(N'2022-07-04T22:55:30.870' AS DateTime), CAST(N'2022-07-04T22:55:30.870' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (541614, N'alayu', CAST(N'2022-07-04T22:55:52.727' AS DateTime), CAST(N'2022-07-04T22:55:52.727' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (541615, N'alayu', CAST(N'2022-07-04T23:04:51.987' AS DateTime), CAST(N'2022-07-04T23:04:51.990' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (541616, N'alayu', CAST(N'2022-07-04T23:10:59.680' AS DateTime), CAST(N'2022-07-04T23:10:59.680' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (541617, N'alayu', CAST(N'2022-07-04T23:12:21.887' AS DateTime), CAST(N'2022-07-04T23:12:21.887' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (541618, N'alayu', CAST(N'2022-07-04T23:24:02.600' AS DateTime), CAST(N'2022-07-04T23:24:02.600' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (541619, N'alayu', CAST(N'2022-07-04T23:24:30.140' AS DateTime), CAST(N'2022-07-04T23:24:30.140' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (541620, N'biruke', CAST(N'2022-07-05T22:09:27.393' AS DateTime), CAST(N'2022-07-05T22:09:27.393' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551612, N'alayu', CAST(N'2022-07-14T14:43:26.877' AS DateTime), CAST(N'2022-07-14T14:43:26.877' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551613, N'alayu', CAST(N'2022-07-14T16:27:20.200' AS DateTime), CAST(N'2022-07-14T16:27:20.200' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551614, N'alayu', CAST(N'2022-07-15T03:08:16.963' AS DateTime), CAST(N'2022-07-15T03:08:16.963' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551615, N'biruke', CAST(N'2022-07-15T03:08:38.367' AS DateTime), CAST(N'2022-07-15T03:08:38.367' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551616, N'biruke', CAST(N'2022-07-15T03:09:57.197' AS DateTime), CAST(N'2022-07-15T03:09:57.197' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551617, N'alayu', CAST(N'2022-07-15T03:10:58.173' AS DateTime), CAST(N'2022-07-15T03:10:58.173' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551618, N'biruke', CAST(N'2022-07-15T03:11:35.817' AS DateTime), CAST(N'2022-07-15T03:11:35.817' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551619, N'biruke', CAST(N'2022-07-15T03:16:29.280' AS DateTime), CAST(N'2022-07-15T03:16:29.283' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551620, N'alayu', CAST(N'2022-07-15T03:18:07.287' AS DateTime), CAST(N'2022-07-15T03:18:07.287' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551621, N'biruke', CAST(N'2022-07-15T03:40:04.170' AS DateTime), CAST(N'2022-07-15T03:40:04.170' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551622, N'alayu', CAST(N'2022-07-16T08:53:24.287' AS DateTime), CAST(N'2022-07-16T08:53:24.287' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551623, N'alayu', CAST(N'2022-07-21T22:22:26.737' AS DateTime), CAST(N'2022-07-21T22:22:26.737' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551624, N'biruke', CAST(N'2022-07-21T22:26:24.897' AS DateTime), CAST(N'2022-07-21T22:26:24.897' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551625, N'biruke', CAST(N'2022-07-21T22:37:23.633' AS DateTime), CAST(N'2022-07-21T22:37:23.633' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551626, N'alayu', CAST(N'2022-07-21T22:37:57.540' AS DateTime), CAST(N'2022-07-21T22:37:57.540' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551627, N'biruke', CAST(N'2022-07-21T22:40:41.727' AS DateTime), CAST(N'2022-07-21T22:40:41.727' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551628, N'biruke', CAST(N'2022-07-21T23:02:45.523' AS DateTime), CAST(N'2022-07-21T23:02:45.523' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551629, N'biruke', CAST(N'2022-07-21T23:03:35.073' AS DateTime), CAST(N'2022-07-21T23:03:35.073' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551630, N'biruke', CAST(N'2022-07-22T00:38:33.117' AS DateTime), CAST(N'2022-07-22T00:38:33.117' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551631, N'biruke', CAST(N'2022-07-22T00:39:32.440' AS DateTime), CAST(N'2022-07-22T00:39:32.440' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551632, N'alayu', CAST(N'2022-07-22T00:48:38.437' AS DateTime), CAST(N'2022-07-22T00:48:38.437' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551633, N'biruke', CAST(N'2022-07-22T00:48:56.570' AS DateTime), CAST(N'2022-07-22T00:48:56.570' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551634, N'biruke', CAST(N'2022-07-22T00:53:27.020' AS DateTime), CAST(N'2022-07-22T00:53:27.020' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551635, N'alayu', CAST(N'2022-07-22T00:53:57.110' AS DateTime), CAST(N'2022-07-22T00:53:57.110' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551636, N'gech', CAST(N'2022-07-22T00:54:39.887' AS DateTime), CAST(N'2022-07-22T00:54:39.887' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551637, N'alayu', CAST(N'2022-07-22T00:54:57.447' AS DateTime), CAST(N'2022-07-22T00:54:57.447' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551638, N'biruke', CAST(N'2022-07-22T00:56:10.867' AS DateTime), CAST(N'2022-07-22T00:56:10.867' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551639, N'gech', CAST(N'2022-07-22T00:57:02.800' AS DateTime), CAST(N'2022-07-22T00:57:02.800' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551640, N'gech', CAST(N'2022-07-22T00:59:05.097' AS DateTime), CAST(N'2022-07-22T00:59:05.097' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551641, N'biruke', CAST(N'2022-07-22T00:59:17.237' AS DateTime), CAST(N'2022-07-22T00:59:17.237' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551642, N'biruke', CAST(N'2022-07-22T01:03:43.740' AS DateTime), CAST(N'2022-07-22T01:03:43.740' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (551643, N'alayu', CAST(N'2022-07-22T01:03:48.900' AS DateTime), CAST(N'2022-07-22T01:03:48.900' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561623, N'biruke', CAST(N'2022-07-22T01:14:38.820' AS DateTime), CAST(N'2022-07-22T01:14:38.820' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561624, N'biruke', CAST(N'2022-07-22T01:32:17.783' AS DateTime), CAST(N'2022-07-22T01:32:17.783' AS DateTime), N'I', N'')
GO
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561625, N'biruke', CAST(N'2022-07-22T01:46:04.513' AS DateTime), CAST(N'2022-07-22T01:46:04.513' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561626, N'gech', CAST(N'2022-07-22T01:47:13.687' AS DateTime), CAST(N'2022-07-22T01:47:13.687' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561627, N'biruke', CAST(N'2022-07-22T01:48:39.863' AS DateTime), CAST(N'2022-07-22T01:48:39.863' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561628, N'gech', CAST(N'2022-07-22T01:49:22.917' AS DateTime), CAST(N'2022-07-22T01:49:22.917' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561629, N'biruke', CAST(N'2022-07-22T01:59:31.403' AS DateTime), CAST(N'2022-07-22T01:59:31.403' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561630, N'gech', CAST(N'2022-07-22T02:00:57.043' AS DateTime), CAST(N'2022-07-22T02:00:57.043' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561631, N'biruke', CAST(N'2022-07-22T02:17:06.287' AS DateTime), CAST(N'2022-07-22T02:17:06.287' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561632, N'biruke', CAST(N'2022-07-22T03:39:47.560' AS DateTime), CAST(N'2022-07-22T03:39:47.560' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561633, N'gech', CAST(N'2022-07-22T03:41:03.250' AS DateTime), CAST(N'2022-07-22T03:41:03.250' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561634, N'biruke', CAST(N'2022-07-22T03:55:04.507' AS DateTime), CAST(N'2022-07-22T03:55:04.507' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561635, N'gech', CAST(N'2022-07-22T04:05:19.537' AS DateTime), CAST(N'2022-07-22T04:05:19.537' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561636, N'biruke', CAST(N'2022-07-22T04:06:59.930' AS DateTime), CAST(N'2022-07-22T04:06:59.930' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561637, N'gech', CAST(N'2022-07-22T04:16:25.833' AS DateTime), CAST(N'2022-07-22T04:16:25.833' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (561638, N'biruke', CAST(N'2022-07-23T01:09:25.140' AS DateTime), CAST(N'2022-07-23T01:09:25.140' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (571623, N'biruke', CAST(N'2022-08-05T05:44:25.773' AS DateTime), CAST(N'2022-08-05T05:44:25.773' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (571624, N'alayu', CAST(N'2022-08-05T05:56:55.930' AS DateTime), CAST(N'2022-08-05T05:56:55.930' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (571625, N'biruke', CAST(N'2022-08-05T05:57:03.653' AS DateTime), CAST(N'2022-08-05T05:57:03.653' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (571626, N'alayu', CAST(N'2022-08-05T05:57:22.843' AS DateTime), CAST(N'2022-08-05T05:57:22.843' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (571627, N'alayu', CAST(N'2022-08-10T01:39:37.977' AS DateTime), CAST(N'2022-08-10T01:39:37.977' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (571628, N'alayu', CAST(N'2022-08-10T22:08:02.880' AS DateTime), CAST(N'2022-08-10T22:08:02.880' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (571629, N'alayu', CAST(N'2022-08-10T23:22:04.640' AS DateTime), CAST(N'2022-08-10T23:22:04.640' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581623, N'biruke', CAST(N'2022-08-11T04:29:41.570' AS DateTime), CAST(N'2022-08-11T04:29:41.570' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581624, N'biruke', CAST(N'2022-08-11T04:31:48.243' AS DateTime), CAST(N'2022-08-11T04:31:48.243' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581625, N'biruke', CAST(N'2022-08-11T04:31:57.623' AS DateTime), CAST(N'2022-08-11T04:31:57.623' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581626, N'alayu', CAST(N'2022-08-11T04:42:12.363' AS DateTime), CAST(N'2022-08-11T04:42:12.363' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581627, N'biruke', CAST(N'2022-08-21T23:47:33.660' AS DateTime), CAST(N'2022-08-21T23:47:33.660' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581628, N'biruke', CAST(N'2022-08-26T10:40:12.777' AS DateTime), CAST(N'2022-08-26T10:40:12.777' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581629, N'biruke', CAST(N'2022-09-05T00:12:14.000' AS DateTime), CAST(N'2022-09-05T00:12:14.000' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581630, N'biruke', CAST(N'2022-09-05T00:15:16.087' AS DateTime), CAST(N'2022-09-05T00:15:16.087' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581631, N'biruke', CAST(N'2022-09-05T00:16:33.357' AS DateTime), CAST(N'2022-09-05T00:16:33.357' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581632, N'biruke', CAST(N'2022-09-05T00:40:47.917' AS DateTime), CAST(N'2022-09-05T00:40:47.917' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581633, N'alayu', CAST(N'2022-09-05T01:40:20.200' AS DateTime), CAST(N'2022-09-05T01:40:20.200' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581634, N'alayu', CAST(N'2022-09-06T01:55:57.180' AS DateTime), CAST(N'2022-09-06T01:55:57.180' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581635, N'alayu', CAST(N'2022-09-06T01:59:08.877' AS DateTime), CAST(N'2022-09-06T01:59:08.877' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581636, N'biruke', CAST(N'2022-09-06T02:04:18.373' AS DateTime), CAST(N'2022-09-06T02:04:18.373' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581637, N'biruke', CAST(N'2022-09-06T02:06:41.493' AS DateTime), CAST(N'2022-09-06T02:06:41.493' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581638, N'biruke', CAST(N'2022-09-06T02:09:22.443' AS DateTime), CAST(N'2022-09-06T02:09:22.443' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581639, N'biruke', CAST(N'2022-09-06T02:11:54.853' AS DateTime), CAST(N'2022-09-06T02:11:54.853' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581640, N'biruke', CAST(N'2022-09-06T02:12:08.403' AS DateTime), CAST(N'2022-09-06T02:12:08.403' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581641, N'biruke', CAST(N'2022-09-06T02:17:27.040' AS DateTime), CAST(N'2022-09-06T02:17:27.040' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581642, N'AlayuDemise', CAST(N'2023-07-09T22:55:31.630' AS DateTime), CAST(N'2023-07-09T22:55:31.630' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581643, N'AlayuDemise', CAST(N'2023-07-09T23:02:03.073' AS DateTime), CAST(N'2023-07-09T23:02:03.073' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581644, N'AlayuDemise', CAST(N'2023-07-09T23:09:13.710' AS DateTime), CAST(N'2023-07-09T23:09:13.710' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581645, N'AlayuDemise', CAST(N'2023-07-09T23:12:00.937' AS DateTime), CAST(N'2023-07-09T23:12:00.937' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581646, N'AlayuDemise', CAST(N'2023-07-09T23:17:55.763' AS DateTime), CAST(N'2023-07-09T23:17:55.763' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581647, N'AlayuDemise', CAST(N'2023-07-10T00:50:29.327' AS DateTime), CAST(N'2023-07-10T00:50:29.327' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581648, N'AlayuDemise', CAST(N'2023-07-10T00:53:39.127' AS DateTime), CAST(N'2023-07-10T00:53:39.127' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581649, N'AlayuDemise', CAST(N'2023-07-10T01:11:15.993' AS DateTime), CAST(N'2023-07-10T01:11:15.993' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581650, N'AlayuDemise', CAST(N'2023-07-10T01:16:47.780' AS DateTime), CAST(N'2023-07-10T01:16:47.780' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581651, N'AlayuDemise', CAST(N'2023-07-10T01:16:50.327' AS DateTime), CAST(N'2023-07-10T01:16:50.327' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581652, N'AlayuDemise', CAST(N'2023-07-10T01:17:36.773' AS DateTime), CAST(N'2023-07-10T01:17:36.773' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581653, N'AlayuDemise', CAST(N'2023-07-10T01:18:26.503' AS DateTime), CAST(N'2023-07-10T01:18:26.503' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581654, N'alayu', CAST(N'2023-07-10T01:28:33.527' AS DateTime), CAST(N'2023-07-10T01:28:33.527' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581655, N'alayu', CAST(N'2023-07-10T01:32:42.187' AS DateTime), CAST(N'2023-07-10T01:32:42.187' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581656, N'alayu', CAST(N'2023-07-10T01:37:40.787' AS DateTime), CAST(N'2023-07-10T01:37:40.787' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581657, N'alayu', CAST(N'2023-07-10T01:40:07.767' AS DateTime), CAST(N'2023-07-10T01:40:07.767' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581658, N'alayu', CAST(N'2023-07-10T01:42:36.770' AS DateTime), CAST(N'2023-07-10T01:42:36.770' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581659, N'alayu', CAST(N'2023-07-10T01:45:49.657' AS DateTime), CAST(N'2023-07-10T01:45:49.657' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581660, N'alayu', CAST(N'2023-07-10T03:25:43.083' AS DateTime), CAST(N'2023-07-10T03:25:43.083' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581661, N'alayu', CAST(N'2023-07-10T03:43:14.627' AS DateTime), CAST(N'2023-07-10T03:43:14.627' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581662, N'alayu', CAST(N'2023-07-10T03:52:35.750' AS DateTime), CAST(N'2023-07-10T03:52:35.750' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581663, N'alayu', CAST(N'2023-07-10T03:57:17.447' AS DateTime), CAST(N'2023-07-10T03:57:17.447' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581664, N'alayu', CAST(N'2023-07-10T04:23:23.520' AS DateTime), CAST(N'2023-07-10T04:23:23.520' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581665, N'alayu', CAST(N'2023-07-10T04:32:34.537' AS DateTime), CAST(N'2023-07-10T04:32:34.537' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581666, N'alayu', CAST(N'2023-07-10T04:34:02.233' AS DateTime), CAST(N'2023-07-10T04:34:02.233' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581667, N'alayu', CAST(N'2023-07-10T04:35:49.747' AS DateTime), CAST(N'2023-07-10T04:35:49.747' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581668, N'alayu', CAST(N'2023-07-10T04:36:50.757' AS DateTime), CAST(N'2023-07-10T04:36:50.757' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581669, N'alayu', CAST(N'2023-07-10T04:44:18.030' AS DateTime), CAST(N'2023-07-10T04:44:18.030' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581670, N'alayu', CAST(N'2023-07-10T04:48:07.910' AS DateTime), CAST(N'2023-07-10T04:48:07.910' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581671, N'alayu', CAST(N'2023-07-10T04:52:08.660' AS DateTime), CAST(N'2023-07-10T04:52:08.660' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581672, N'alayu', CAST(N'2023-07-10T23:54:40.370' AS DateTime), CAST(N'2023-07-10T23:54:40.370' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581673, N'alayu', CAST(N'2023-07-12T00:34:32.477' AS DateTime), CAST(N'2023-07-12T00:34:32.477' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581674, N'alayu', CAST(N'2023-07-12T00:37:01.007' AS DateTime), CAST(N'2023-07-12T00:37:01.007' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581675, N'alayu', CAST(N'2023-07-12T01:43:28.217' AS DateTime), CAST(N'2023-07-12T01:43:28.217' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581676, N'alayu', CAST(N'2023-07-12T01:45:21.153' AS DateTime), CAST(N'2023-07-12T01:45:21.153' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581677, N'alayu', CAST(N'2023-07-12T03:40:21.130' AS DateTime), CAST(N'2023-07-12T03:40:21.130' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581678, N'alayu', CAST(N'2023-07-12T03:42:46.303' AS DateTime), CAST(N'2023-07-12T03:42:46.303' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581679, N'alayu', CAST(N'2023-07-12T03:44:38.513' AS DateTime), CAST(N'2023-07-12T03:44:38.513' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581680, N'alayu', CAST(N'2023-07-12T03:53:08.640' AS DateTime), CAST(N'2023-07-12T03:53:08.640' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581681, N'alayu', CAST(N'2023-07-12T03:58:20.270' AS DateTime), CAST(N'2023-07-12T03:58:20.270' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581682, N'alayu', CAST(N'2023-07-12T04:26:34.020' AS DateTime), CAST(N'2023-07-12T04:26:34.020' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581683, N'alayu', CAST(N'2023-07-12T04:28:18.843' AS DateTime), CAST(N'2023-07-12T04:28:18.843' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581684, N'alayu', CAST(N'2023-07-12T04:37:05.380' AS DateTime), CAST(N'2023-07-12T04:37:05.380' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581685, N'alayu', CAST(N'2023-07-12T05:11:28.720' AS DateTime), CAST(N'2023-07-12T05:11:28.720' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581686, N'alayu', CAST(N'2023-07-12T05:38:21.030' AS DateTime), CAST(N'2023-07-12T05:38:21.030' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581687, N'alayu', CAST(N'2023-07-12T06:08:35.207' AS DateTime), CAST(N'2023-07-12T06:08:35.207' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581688, N'alayu', CAST(N'2023-07-12T06:15:35.717' AS DateTime), CAST(N'2023-07-12T06:15:35.717' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581689, N'alayu', CAST(N'2023-07-12T06:30:41.367' AS DateTime), CAST(N'2023-07-12T06:30:41.367' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581690, N'alayu', CAST(N'2023-07-12T06:48:47.007' AS DateTime), CAST(N'2023-07-12T06:48:47.010' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581691, N'alayu', CAST(N'2023-07-12T07:07:55.463' AS DateTime), CAST(N'2023-07-12T07:07:55.463' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581692, N'alayu', CAST(N'2023-07-12T07:09:37.303' AS DateTime), CAST(N'2023-07-12T07:09:37.303' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581693, N'alayu', CAST(N'2023-07-12T07:11:39.943' AS DateTime), CAST(N'2023-07-12T07:11:39.943' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581694, N'alayu', CAST(N'2023-07-12T07:15:36.783' AS DateTime), CAST(N'2023-07-12T07:15:36.783' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581695, N'alayu', CAST(N'2023-07-12T07:30:18.367' AS DateTime), CAST(N'2023-07-12T07:30:18.370' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581696, N'alayu', CAST(N'2023-07-12T07:31:35.123' AS DateTime), CAST(N'2023-07-12T07:31:35.123' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581697, N'alayu', CAST(N'2023-07-12T07:37:13.793' AS DateTime), CAST(N'2023-07-12T07:37:13.793' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581698, N'alayu', CAST(N'2023-07-12T07:40:59.357' AS DateTime), CAST(N'2023-07-12T07:40:59.357' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581699, N'alayu', CAST(N'2023-07-12T07:42:34.053' AS DateTime), CAST(N'2023-07-12T07:42:34.053' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581700, N'alayu', CAST(N'2023-07-12T07:48:20.977' AS DateTime), CAST(N'2023-07-12T07:48:20.977' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581701, N'alayu', CAST(N'2023-07-12T07:56:50.227' AS DateTime), CAST(N'2023-07-12T07:56:50.227' AS DateTime), N'I', N'')
GO
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581702, N'alayu', CAST(N'2023-07-12T22:31:19.890' AS DateTime), CAST(N'2023-07-12T22:31:19.890' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581703, N'alayu', CAST(N'2023-07-12T22:37:47.273' AS DateTime), CAST(N'2023-07-12T22:37:47.273' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581704, N'merchant1', CAST(N'2023-07-12T22:41:21.540' AS DateTime), CAST(N'2023-07-12T22:41:21.540' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581705, N'alayu', CAST(N'2023-07-12T22:48:11.910' AS DateTime), CAST(N'2023-07-12T22:48:11.910' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581706, N'alayu', CAST(N'2023-07-12T22:50:07.083' AS DateTime), CAST(N'2023-07-12T22:50:07.083' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581707, N'merchant1', CAST(N'2023-07-12T22:50:16.873' AS DateTime), CAST(N'2023-07-12T22:50:16.873' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581708, N'alayu', CAST(N'2023-07-17T00:41:19.270' AS DateTime), CAST(N'2023-07-17T00:41:19.270' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581709, N'alayu', CAST(N'2023-07-17T00:52:01.210' AS DateTime), CAST(N'2023-07-17T00:52:01.210' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581710, N'alayu', CAST(N'2023-07-17T00:52:37.663' AS DateTime), CAST(N'2023-07-17T00:52:37.663' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581711, N'alayu', CAST(N'2023-07-17T00:53:15.813' AS DateTime), CAST(N'2023-07-17T00:53:15.813' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581712, N'alayu', CAST(N'2023-07-19T04:11:40.767' AS DateTime), CAST(N'2023-07-19T04:11:40.767' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581713, N'alayu', CAST(N'2023-07-19T04:19:45.920' AS DateTime), CAST(N'2023-07-19T04:19:45.920' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581714, N'alayu', CAST(N'2023-07-19T04:23:35.970' AS DateTime), CAST(N'2023-07-19T04:23:35.970' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581715, N'alayu', CAST(N'2023-07-19T04:26:10.967' AS DateTime), CAST(N'2023-07-19T04:26:10.967' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581716, N'alayu', CAST(N'2023-07-19T04:28:02.603' AS DateTime), CAST(N'2023-07-19T04:28:02.603' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581717, N'alayu', CAST(N'2023-07-19T04:36:37.260' AS DateTime), CAST(N'2023-07-19T04:36:37.260' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581718, N'alayu', CAST(N'2023-07-19T04:41:38.593' AS DateTime), CAST(N'2023-07-19T04:41:38.593' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581719, N'alayu', CAST(N'2023-07-23T23:09:56.860' AS DateTime), CAST(N'2023-07-23T23:09:56.860' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581720, N'alayu', CAST(N'2023-07-23T23:45:12.223' AS DateTime), CAST(N'2023-07-23T23:45:12.223' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581721, N'alayu', CAST(N'2023-07-23T23:45:12.783' AS DateTime), CAST(N'2023-07-23T23:45:12.783' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581722, N'alayu', CAST(N'2023-07-28T05:31:54.567' AS DateTime), CAST(N'2023-07-28T05:31:54.567' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581723, N'alayu', CAST(N'2023-07-28T05:45:32.017' AS DateTime), CAST(N'2023-07-28T05:45:32.017' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581724, N'alayu', CAST(N'2023-07-28T06:14:10.053' AS DateTime), CAST(N'2023-07-28T06:14:10.053' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581725, N'alayu', CAST(N'2023-07-28T06:15:59.257' AS DateTime), CAST(N'2023-07-28T06:15:59.257' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581726, N'alayu', CAST(N'2023-07-28T06:17:07.293' AS DateTime), CAST(N'2023-07-28T06:17:07.293' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581727, N'alayu', CAST(N'2023-07-28T06:19:38.143' AS DateTime), CAST(N'2023-07-28T06:19:38.143' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581728, N'alayu', CAST(N'2023-08-02T05:58:53.993' AS DateTime), CAST(N'2023-08-02T05:58:53.993' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581729, N'alayu', CAST(N'2023-08-02T06:01:51.810' AS DateTime), CAST(N'2023-08-02T06:01:51.810' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581730, N'alayu', CAST(N'2023-08-02T06:23:28.253' AS DateTime), CAST(N'2023-08-02T06:23:28.253' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581731, N'alayu', CAST(N'2023-08-02T22:16:39.700' AS DateTime), CAST(N'2023-08-02T22:16:39.700' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581732, N'aa', CAST(N'2023-08-02T22:17:34.677' AS DateTime), CAST(N'2023-08-02T22:17:34.677' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581733, N'aa', CAST(N'2023-08-02T22:21:25.360' AS DateTime), CAST(N'2023-08-02T22:21:25.360' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581734, N'alayu', CAST(N'2023-08-02T22:37:34.733' AS DateTime), CAST(N'2023-08-02T22:37:34.733' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581735, N'alayu', CAST(N'2023-08-03T00:43:00.237' AS DateTime), CAST(N'2023-08-03T00:43:00.237' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581736, N'alayu', CAST(N'2023-08-03T00:43:56.730' AS DateTime), CAST(N'2023-08-03T00:43:56.730' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581737, N'alayu', CAST(N'2023-08-03T00:44:06.297' AS DateTime), CAST(N'2023-08-03T00:44:06.297' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581738, N'test', CAST(N'2023-08-03T00:55:08.850' AS DateTime), CAST(N'2023-08-03T00:55:08.850' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581739, N'alayu', CAST(N'2023-08-03T00:56:05.793' AS DateTime), CAST(N'2023-08-03T00:56:05.793' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581740, N'test', CAST(N'2023-08-03T00:59:28.313' AS DateTime), CAST(N'2023-08-03T00:59:28.313' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581741, N'test', CAST(N'2023-08-03T00:59:39.090' AS DateTime), CAST(N'2023-08-03T00:59:39.090' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581742, N'test', CAST(N'2023-08-03T00:59:53.767' AS DateTime), CAST(N'2023-08-03T00:59:53.767' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581743, N'alayu', CAST(N'2023-08-03T01:00:09.543' AS DateTime), CAST(N'2023-08-03T01:00:09.543' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581744, N'alayu', CAST(N'2023-08-03T01:00:43.993' AS DateTime), CAST(N'2023-08-03T01:00:43.993' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581745, N'test', CAST(N'2023-08-03T01:01:26.817' AS DateTime), CAST(N'2023-08-03T01:01:26.817' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581746, N'alayu', CAST(N'2023-08-03T01:20:21.043' AS DateTime), CAST(N'2023-08-03T01:20:21.043' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581747, N'alayu', CAST(N'2023-08-03T03:19:35.210' AS DateTime), CAST(N'2023-08-03T03:19:35.210' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581748, N'alayu', CAST(N'2023-08-03T04:01:39.340' AS DateTime), CAST(N'2023-08-03T04:01:39.340' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581749, N'alayu', CAST(N'2023-08-03T04:06:36.037' AS DateTime), CAST(N'2023-08-03T04:06:36.037' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581750, N'alayu', CAST(N'2023-08-03T04:14:04.933' AS DateTime), CAST(N'2023-08-03T04:14:04.933' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581751, N'alayu', CAST(N'2023-08-03T04:21:38.103' AS DateTime), CAST(N'2023-08-03T04:21:38.103' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581752, N'alayu', CAST(N'2023-08-03T04:39:49.623' AS DateTime), CAST(N'2023-08-03T04:39:49.623' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581753, N'alayu', CAST(N'2023-08-03T04:58:58.480' AS DateTime), CAST(N'2023-08-03T04:58:58.480' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581754, N'alayu d', CAST(N'2023-08-03T05:04:38.420' AS DateTime), CAST(N'2023-08-03T05:04:38.420' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581755, N'alayu', CAST(N'2023-08-03T05:05:08.740' AS DateTime), CAST(N'2023-08-03T05:05:08.740' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581756, N'alayu', CAST(N'2023-08-03T05:09:54.410' AS DateTime), CAST(N'2023-08-03T05:09:54.410' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581757, N'alayu', CAST(N'2023-08-03T05:27:31.690' AS DateTime), CAST(N'2023-08-03T05:27:31.690' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581758, N'alayu', CAST(N'2023-08-03T05:35:49.140' AS DateTime), CAST(N'2023-08-03T05:35:49.140' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581759, N'alayu', CAST(N'2023-08-03T05:38:51.940' AS DateTime), CAST(N'2023-08-03T05:38:51.940' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581760, N'alayu', CAST(N'2023-08-03T05:40:01.480' AS DateTime), CAST(N'2023-08-03T05:40:01.480' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581761, N'alayu', CAST(N'2023-08-03T05:43:02.080' AS DateTime), CAST(N'2023-08-03T05:43:02.080' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581762, N'alayu', CAST(N'2023-08-03T05:44:14.340' AS DateTime), CAST(N'2023-08-03T05:44:14.340' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581763, N'alayu', CAST(N'2023-08-03T05:56:02.433' AS DateTime), CAST(N'2023-08-03T05:56:02.433' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581764, N'alayu', CAST(N'2023-08-03T05:58:01.097' AS DateTime), CAST(N'2023-08-03T05:58:01.100' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581765, N'alayu', CAST(N'2023-08-03T05:59:33.970' AS DateTime), CAST(N'2023-08-03T05:59:33.970' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581766, N'alayu', CAST(N'2023-08-03T05:59:41.507' AS DateTime), CAST(N'2023-08-03T05:59:41.507' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581767, N'alayu', CAST(N'2023-08-03T06:00:19.640' AS DateTime), CAST(N'2023-08-03T06:00:19.640' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581768, N'alayu', CAST(N'2023-08-04T05:01:09.920' AS DateTime), CAST(N'2023-08-04T05:01:09.920' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581769, N'alayu', CAST(N'2023-08-04T05:06:47.883' AS DateTime), CAST(N'2023-08-04T05:06:47.883' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581770, N'alayu', CAST(N'2023-08-04T05:11:15.833' AS DateTime), CAST(N'2023-08-04T05:11:15.833' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581771, N'alayu', CAST(N'2023-08-04T05:19:59.073' AS DateTime), CAST(N'2023-08-04T05:19:59.073' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581772, N'alayu', CAST(N'2023-08-04T05:32:28.247' AS DateTime), CAST(N'2023-08-04T05:32:28.247' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581773, N'alayu', CAST(N'2023-08-04T05:33:59.947' AS DateTime), CAST(N'2023-08-04T05:33:59.947' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581774, N'alayu', CAST(N'2023-08-04T05:36:03.737' AS DateTime), CAST(N'2023-08-04T05:36:03.737' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581775, N'alayu', CAST(N'2023-08-04T05:37:49.150' AS DateTime), CAST(N'2023-08-04T05:37:49.150' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581776, N'alayu', CAST(N'2023-08-04T05:39:01.803' AS DateTime), CAST(N'2023-08-04T05:39:01.803' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (581777, N'alayu', CAST(N'2023-08-04T05:44:14.063' AS DateTime), CAST(N'2023-08-04T05:44:14.063' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (591719, N'alayu', CAST(N'2023-08-22T01:28:18.267' AS DateTime), CAST(N'2023-08-22T01:28:18.267' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (591720, N'alayu', CAST(N'2023-08-22T02:54:23.797' AS DateTime), CAST(N'2023-08-22T02:54:23.797' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (601719, N'alayu', CAST(N'2023-09-20T00:04:40.660' AS DateTime), CAST(N'2023-09-20T00:04:40.660' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (601720, N'alayu', CAST(N'2023-09-20T00:22:19.083' AS DateTime), CAST(N'2023-09-20T00:22:19.083' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (601721, N't', CAST(N'2023-09-20T00:24:06.497' AS DateTime), CAST(N'2023-09-20T00:24:06.497' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (601722, N't', CAST(N'2023-09-20T00:28:39.857' AS DateTime), CAST(N'2023-09-20T00:28:39.857' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (601723, N'alayu', CAST(N'2023-09-20T00:29:00.123' AS DateTime), CAST(N'2023-09-20T00:29:00.123' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (601724, N'alayu', CAST(N'2023-09-20T00:30:14.000' AS DateTime), CAST(N'2023-09-20T00:30:14.000' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (601725, N'p', CAST(N'2023-09-20T00:31:15.060' AS DateTime), CAST(N'2023-09-20T00:31:15.060' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (601726, N'alayu', CAST(N'2023-09-20T00:33:04.350' AS DateTime), CAST(N'2023-09-20T00:33:04.350' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (601727, N'alayu', CAST(N'2023-09-20T00:36:31.600' AS DateTime), CAST(N'2023-09-20T00:36:31.600' AS DateTime), N'I', N'')
INSERT [dbo].[LogInOut] ([Id], [UserID], [LogInDT], [LogOutDT], [Status], [UserHost]) VALUES (601728, N'alayu', CAST(N'2023-09-20T00:38:47.353' AS DateTime), CAST(N'2023-09-20T00:38:47.353' AS DateTime), N'I', N'')
SET IDENTITY_INSERT [dbo].[LogInOut] OFF
GO
INSERT [dbo].[MerchantAppMerchantInfo] ([Id], [Shortcode], [Phone], [Password], [KYC], [Status], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'008d6e93-7130-4829-a49b-4baab650414e', N'0102', N'0978784545', N'123456', N'KYC 2', N'True', CAST(N'2023-07-19T04:38:27.877' AS DateTime), CAST(N'2023-07-19T04:38:27.877' AS DateTime), N'alayu', N'alayu')
GO
INSERT [dbo].[MerchantAppSalersList] ([Id], [SalersPhone], [EncryptionKey], [Shortcode], [Status], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'1543811f-c235-4f99-974e-a71ad4597fc4', N'0945457878', N'KEY1', N'722300', N'Active', CAST(N'2022-09-08T04:04:34.750' AS DateTime), CAST(N'2023-07-19T04:43:28.940' AS DateTime), N'system', N'alayu')
GO
SET IDENTITY_INSERT [dbo].[MerchantAppSimulation] ON 

INSERT [dbo].[MerchantAppSimulation] ([Id], [Phone], [MerchantShortCode], [MerchantName], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (3, N'0944445555', N'123456', N'Abebe Kebede', CAST(N'2023-08-03T00:53:28.077' AS DateTime), CAST(N'2023-08-03T00:53:28.077' AS DateTime), N'alayu', N'alayu')
INSERT [dbo].[MerchantAppSimulation] ([Id], [Phone], [MerchantShortCode], [MerchantName], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (4, N'w', N'w', N'w w', CAST(N'2023-08-03T05:40:30.913' AS DateTime), CAST(N'2023-08-03T05:40:30.913' AS DateTime), N'alayu', N'alayu')
INSERT [dbo].[MerchantAppSimulation] ([Id], [Phone], [MerchantShortCode], [MerchantName], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10002, N't', N't', N't t', CAST(N'2023-09-20T00:22:45.087' AS DateTime), CAST(N'2023-09-20T00:22:45.180' AS DateTime), N'alayu', N'alayu')
INSERT [dbo].[MerchantAppSimulation] ([Id], [Phone], [MerchantShortCode], [MerchantName], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10003, N'q', N'q', N'q q', CAST(N'2023-09-20T00:29:32.583' AS DateTime), CAST(N'2023-09-20T00:29:32.583' AS DateTime), N'alayu', N'alayu')
INSERT [dbo].[MerchantAppSimulation] ([Id], [Phone], [MerchantShortCode], [MerchantName], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (10004, N'p', N'p', N'p p', CAST(N'2023-09-20T00:30:34.590' AS DateTime), CAST(N'2023-09-20T00:30:34.590' AS DateTime), N'alayu', N'alayu')
SET IDENTITY_INSERT [dbo].[MerchantAppSimulation] OFF
GO
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'3e64badc-43b5-4292-bfbc-0000e23c9d0d', N'722300', N'251911372930', CAST(6500.00 AS Decimal(15, 2)), N'AFT7CCYK45', N'Approved', N'251913548054', CAST(N'2023-06-29T14:34:18.380' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'ffd951bb-8c68-4150-90a9-003076ab5d7f', N'722300', N'251913011341', CAST(5000.00 AS Decimal(15, 2)), N'AG67CF58I9', N'Approved', N'251913559285', CAST(N'2023-07-06T16:40:54.473' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'032248b9-9dbd-4443-aa85-00382c477e84', N'722300', N'251923576288', CAST(6500.00 AS Decimal(15, 2)), N'AG43CE8RBL', N'Approved', N'251913548054', CAST(N'2023-07-04T09:38:21.550' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'f1b8a7d2-0c7c-4652-85c2-00393eb84a56', N'722300', N'251910119870', CAST(6500.00 AS Decimal(15, 2)), N'AFL9CALFZV', N'Approved', N'251913559285', CAST(N'2023-06-21T11:12:04.277' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'8e547cf7-9b5e-49cd-bf86-003eece228d4', N'722300', N'251983084888', CAST(5000.00 AS Decimal(15, 2)), N'AG47CEAPRJ', N'Approved', N'251913559285', CAST(N'2023-07-04T11:34:01.667' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'80af31e5-27c4-4aa2-846b-005a5c5b9f22', N'722300', N'251977657770', CAST(6500.00 AS Decimal(15, 2)), N'AFE9C8K4BJ', N'Approved', N'251913548054', CAST(N'2023-06-14T16:31:13.063' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'5ae7d945-f593-4398-a350-00714c928708', N'722300', N'251905946295', CAST(5000.00 AS Decimal(15, 2)), N'AEM0C0TMKM', N'Approved', N'251913548054', CAST(N'2023-05-22T10:50:30.557' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'220fd54d-395f-4603-a09a-0086d3f92228', N'722300', N'251912464799', CAST(5000.00 AS Decimal(15, 2)), N'AF50C5ELO4', N'Approved', N'251913548054', CAST(N'2023-06-05T14:12:36.553' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'f2ce9be0-0751-4228-ae11-00aa793f1b3c', N'722300', N'251911024493', CAST(1.00 AS Decimal(15, 2)), N'AEF7BX7WO5', N'Approved', N'251991883672', CAST(N'2023-05-15T09:05:56.350' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'e785b4b6-1ee8-44d4-93de-00c31995e32f', N'722300', N'251974897526', CAST(5000.00 AS Decimal(15, 2)), N'AFT6CCY3N2', N'Approved', N'251913559285', CAST(N'2023-06-29T13:54:43.093' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'c5ef2227-8daf-459d-8c29-00d2b01abfe4', N'722300', N'251934593541', CAST(5000.00 AS Decimal(15, 2)), N'AFE7C8ICH5', N'Approved', N'251913548054', CAST(N'2023-06-14T14:46:05.960' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'77a9ac34-3ad3-407c-927c-00e679919ec9', N'722300', N'251978845505', CAST(6500.00 AS Decimal(15, 2)), N'AG49CE98V5', N'Approved', N'251913559285', CAST(N'2023-07-04T10:06:47.483' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'2975a253-3b50-4ad9-aa7b-00ee6c33b3b6', N'722300', N'251946701475', CAST(10000.00 AS Decimal(15, 2)), N'AFT3CCY8S9', N'Approved', N'251913548054', CAST(N'2023-06-29T14:07:14.190' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'9cea2405-88cf-4d48-a1d6-01020275b869', N'722300', N'251931677777', CAST(6500.00 AS Decimal(15, 2)), N'AFG0C93C72', N'Approved', N'251913548054', CAST(N'2023-06-16T11:04:35.683' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'6dd5a926-ee7f-4579-b81f-012df277b47e', N'722300', N'251912182032', CAST(6500.00 AS Decimal(15, 2)), N'AFJ6C9XO8K', N'Approved', N'251913559285', CAST(N'2023-06-19T12:06:01.440' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'91560aed-96a4-422e-b9f7-0131ceed8507', N'722300', N'251912157058', CAST(5000.00 AS Decimal(15, 2)), N'AFQ2CC28QC', N'Approved', N'251913548054', CAST(N'2023-06-26T11:55:35.017' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'2a247a3f-8ede-4226-a4bb-013ce6b86b5c', N'722300', N'251923041365', CAST(6500.00 AS Decimal(15, 2)), N'AFR1CCC3ZR', N'Approved', N'251913559285', CAST(N'2023-06-27T10:16:03.587' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'41febafe-1e54-41e1-97fd-016bcf3dd651', N'722300', N'251920775166', CAST(5000.00 AS Decimal(15, 2)), N'AFE1C8D6Y3', N'Approved', N'251913548054', CAST(N'2023-06-14T09:22:20.733' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'31f8f6e7-ad85-4269-9a90-01719b8267e7', N'722300', N'251916366564', CAST(5000.00 AS Decimal(15, 2)), N'AFQ8CC1ZM6', N'Approved', N'251913548054', CAST(N'2023-06-26T11:39:00.097' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'234a6864-80dd-45e2-8f2b-017e79c6fca7', N'722300', N'251933532835', CAST(5000.00 AS Decimal(15, 2)), N'AFR6CCH7OE', N'Approved', N'251913548054', CAST(N'2023-06-27T16:44:19.617' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'd23bd589-ff4b-4b40-b426-0184f70f5e4a', N'722300', N'251989059053', CAST(6500.00 AS Decimal(15, 2)), N'AFJ6C9W3QE', N'Approved', N'251913559285', CAST(N'2023-06-19T10:30:31.023' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'f173dc23-9b62-46a8-ba37-01909c7c7ecb', N'722300', N'251923772050', CAST(6500.00 AS Decimal(15, 2)), N'AFJ3C9XLZX', N'Approved', N'251913559285', CAST(N'2023-06-19T12:01:24.340' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'debc044f-7e9e-42a4-ba99-01ae3d0de431', N'722300', N'251954878444', CAST(5000.00 AS Decimal(15, 2)), N'AFT0CCVWZI', N'Approved', N'251913548054', CAST(N'2023-06-29T11:01:00.120' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'7e34d4ab-70fb-4779-9044-01bf7cbb9d6f', N'722300', N'251970464268', CAST(5000.00 AS Decimal(15, 2)), N'AF79C661N1', N'Approved', N'251913559285', CAST(N'2023-06-07T13:36:55.530' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'd27f6675-7484-4020-81ee-02056864fe78', N'722300', N'251944108871', CAST(6500.00 AS Decimal(15, 2)), N'AEM6C0SCP4', N'Approved', N'251913548054', CAST(N'2023-05-22T09:35:00.283' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'9335e5bc-e1a3-43c0-a58c-020f9cb59231', N'722300', N'251911399619', CAST(6500.00 AS Decimal(15, 2)), N'AGA1CG8B8V', N'Approved', N'251913548054', CAST(N'2023-07-10T10:38:35.787' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'e74ed35b-dd25-4c95-ab45-02326bca1f1c', N'722300', N'251954830723', CAST(6500.00 AS Decimal(15, 2)), N'AFE1C8I927', N'Approved', N'251913548054', CAST(N'2023-06-14T14:41:00.193' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'6fb2eaba-108a-425d-95e1-023297fb524f', N'722300', N'251900575452', CAST(5000.00 AS Decimal(15, 2)), N'AFT1CCUZA7', N'Approved', N'251913548054', CAST(N'2023-06-29T09:56:33.643' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'9e3362b9-e6dd-480e-91fa-024cb991083d', N'722300', N'251910629750', CAST(6500.00 AS Decimal(15, 2)), N'AFT6CCVN7Q', N'Approved', N'251913548054', CAST(N'2023-06-29T10:44:01.983' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'3a706b35-a142-4335-864c-0250a77720df', N'722300', N'251932212720', CAST(2500.00 AS Decimal(15, 2)), N'AG55CEPO4B', N'Approved', N'251913559285', CAST(N'2023-07-05T14:04:07.040' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'a9863fef-c7ff-4ae2-8e8a-02519ac2ac1e', N'722300', N'251910384922', CAST(6500.00 AS Decimal(15, 2)), N'AFL1CAOF5P', N'Approved', N'251913548054', CAST(N'2023-06-21T14:45:52.330' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'84179439-5e0d-4ecc-ab3f-0274b85be4e2', N'722300', N'251935155100', CAST(6500.00 AS Decimal(15, 2)), N'AFR2CCG6R4', N'Approved', N'251913559285', CAST(N'2023-06-27T15:31:46.957' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'5161d15a-d721-4e88-a901-027637a75662', N'722300', N'251962014777', CAST(6500.00 AS Decimal(15, 2)), N'AFE5C8EOEN', N'Approved', N'251913559285', CAST(N'2023-06-14T10:45:56.180' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'b11a31ab-8666-46ac-8e73-02842c30b623', N'722300', N'251929906158', CAST(6500.00 AS Decimal(15, 2)), N'AEG2BXR30S', N'Approved', N'251913548054', CAST(N'2023-05-16T08:54:57.893' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'bbaaedbb-c53d-4873-bc54-02a30759a48e', N'722300', N'251912273886', CAST(5000.00 AS Decimal(15, 2)), N'AEU2C3HUSC', N'Approved', N'251913548054', CAST(N'2023-05-30T12:23:36.790' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'04dfd559-7e02-48a5-9ea0-02ac661ccd1f', N'722300', N'251916678254', CAST(5000.00 AS Decimal(15, 2)), N'AG63CF3LH5', N'Approved', N'251913548054', CAST(N'2023-07-06T15:00:33.293' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'69e08098-52be-4283-8180-02b4e1feede7', N'722300', N'251911349307', CAST(6500.00 AS Decimal(15, 2)), N'AFJ2C9VNAM', N'Approved', N'251913559285', CAST(N'2023-06-19T10:03:30.057' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'3783fbeb-49f8-48dd-acaa-02d8d5a7fd56', N'722300', N'251911509989', CAST(5000.00 AS Decimal(15, 2)), N'AFT7CCZ0YT', N'Approved', N'251913559285', CAST(N'2023-06-29T15:08:20.063' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'dd04e839-789b-48c6-9db5-02ee86fcae26', N'722300', N'251914094755', CAST(5000.00 AS Decimal(15, 2)), N'AFC4C7TXF8', N'Approved', N'251913548054', CAST(N'2023-06-12T16:47:48.663' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'77a7adf7-fb24-4a62-a5ba-03218257c4d6', N'722300', N'251973531688', CAST(6500.00 AS Decimal(15, 2)), N'AFG5C95L7L', N'Approved', N'251913548054', CAST(N'2023-06-16T13:52:11.413' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'bd48745b-6e74-416c-9301-033b7fe0dbd3', N'722300', N'251905156678', CAST(6500.00 AS Decimal(15, 2)), N'AG66CF424Y', N'Approved', N'251913548054', CAST(N'2023-07-06T15:28:19.733' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'9dc1dad4-f178-4353-bbfa-034fc38e0b78', N'722300', N'251928775358', CAST(6500.00 AS Decimal(15, 2)), N'AFL4CANTTQ', N'Approved', N'251913548054', CAST(N'2023-06-21T14:03:30.513' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'057b21e2-1e7f-4a4f-be0d-035cfa426ceb', N'722300', N'251947990001', CAST(5000.00 AS Decimal(15, 2)), N'AEG0BXXMRO', N'Approved', N'251913548054', CAST(N'2023-05-16T11:57:13.740' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'e585d767-72a2-4b80-86b8-0361fa7af59c', N'722300', N'251911367398', CAST(6500.00 AS Decimal(15, 2)), N'AGA6CGC8W6', N'Approved', N'251913548054', CAST(N'2023-07-10T14:28:48.713' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'ac2677c3-565f-49e6-aa30-037ad583091f', N'624626', N'251965183828', CAST(2.00 AS Decimal(15, 2)), N'AD85BJS45D', N'Approved', N'251965183828', CAST(N'2023-04-08T08:34:22.493' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'f7ac0b0d-d522-4708-a041-037d5bbf282b', N'722300', N'251905257091', CAST(5000.00 AS Decimal(15, 2)), N'AGB0CGPZ7U', N'Approved', N'251913559285', CAST(N'2023-07-11T14:53:36.460' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'9ba525b9-ba2c-4dc4-81e7-038700d5ad9a', N'722300', N'251918525171', CAST(9750.00 AS Decimal(15, 2)), N'AF56C5ABLC', N'Approved', N'251913559285', CAST(N'2023-06-05T10:02:38.560' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'68effa85-151d-40e9-a25c-0396e3359f29', N'722300', N'251970501763', CAST(6500.00 AS Decimal(15, 2)), N'AFG3C969IT', N'Approved', N'251913548054', CAST(N'2023-06-16T14:39:24.080' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'ec551f53-9b51-4fe7-b341-039d5abe6591', N'722300', N'251939808250', CAST(6500.00 AS Decimal(15, 2)), N'AG39CE2KI3', N'Approved', N'251913559285', CAST(N'2023-07-03T16:12:56.827' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'2250c844-aff2-4592-a1f0-03d09f1d8afc', N'722300', N'251914784716', CAST(6500.00 AS Decimal(15, 2)), N'AG58CENC66', N'Approved', N'251913559285', CAST(N'2023-07-05T11:26:04.987' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'5462d4f6-fee1-4116-a61f-03d12c209d91', N'722300', N'251901337213', CAST(6500.00 AS Decimal(15, 2)), N'AEI6BZNR14', N'Approved', N'251913548054', CAST(N'2023-05-18T16:04:24.967' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'c6836739-e9b5-48d5-96a4-03f4a1f40dd0', N'722300', N'251940498097', CAST(5000.00 AS Decimal(15, 2)), N'AF97C6RREL', N'Approved', N'251913559285', CAST(N'2023-06-09T09:21:55.503' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'386f5e8f-ecd1-4dad-90c2-03f553848873', N'722300', N'251911125035', CAST(6500.00 AS Decimal(15, 2)), N'AEP9C1UKID', N'Approved', N'251913548054', CAST(N'2023-05-25T11:10:22.640' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'41b3e3f6-0c2b-48c1-b9db-041f8af043ce', N'722300', N'251919589143', CAST(5000.00 AS Decimal(15, 2)), N'AFN0CBE1Q6', N'Approved', N'251913548054', CAST(N'2023-06-23T16:07:50.450' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'7cb27cc7-62b1-42b1-a127-045668c3f740', N'722300', N'251921739543', CAST(6500.00 AS Decimal(15, 2)), N'AFR5CCDU8P', N'Approved', N'251913548054', CAST(N'2023-06-27T12:19:17.543' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'ae074f35-2a00-40c7-b315-047d98d9d109', N'722300', N'251912399531', CAST(5000.00 AS Decimal(15, 2)), N'AFR0CCF1OG', N'Approved', N'251913559285', CAST(N'2023-06-27T14:07:17.547' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'dc42f4c8-9361-4c2a-a0ac-048c5759cdf7', N'722300', N'251917682670', CAST(6500.00 AS Decimal(15, 2)), N'AFQ7CBZKYP', N'Approved', N'251913548054', CAST(N'2023-06-26T08:54:34.960' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'6f075e0e-b9f4-4739-965b-049c458f718c', N'722300', N'251911134789', CAST(6500.00 AS Decimal(15, 2)), N'AGB0CGRQRM', N'Approved', N'251913548054', CAST(N'2023-07-11T16:33:11.410' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'43268333-f1fb-4339-b572-04a1d7f8bf8c', N'722300', N'251920326755', CAST(5000.00 AS Decimal(15, 2)), N'AFR1CCG8BR', N'Approved', N'251913559285', CAST(N'2023-06-27T15:34:50.903' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'252e3a75-5921-445d-a454-04a9d423e277', N'722300', N'251936376988', CAST(5000.00 AS Decimal(15, 2)), N'AEI1BZNDZ9', N'Approved', N'251913559285', CAST(N'2023-05-18T15:40:57.533' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'3d4ac202-22d8-47c0-b0ef-04af7c05f14a', N'722300', N'251913472390', CAST(5000.00 AS Decimal(15, 2)), N'AFC3C7TCZ3', N'Approved', N'251913548054', CAST(N'2023-06-12T16:14:52.407' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'c63da327-59b8-4e47-a40d-04ba2b74342f', N'722300', N'251965189903', CAST(6500.00 AS Decimal(15, 2)), N'AEU0C3GZUO', N'Approved', N'251913548054', CAST(N'2023-05-30T11:30:40.533' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'b6472afc-c75b-48af-b1be-04cece1c2f92', N'722300', N'251960243743', CAST(5000.00 AS Decimal(15, 2)), N'AEV5C3UYWT', N'Approved', N'251913559285', CAST(N'2023-05-31T14:26:29.220' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'9897fe12-30fd-4bc9-becc-04f2d3147aa3', N'722300', N'251904852982', CAST(6500.00 AS Decimal(15, 2)), N'AGA4CG8TUO', N'Approved', N'251913559285', CAST(N'2023-07-10T11:05:10.357' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'c67bb9d6-15bb-4856-9d39-04f747f0b1e1', N'722300', N'251935896065', CAST(6500.00 AS Decimal(15, 2)), N'AEG5BY09QF', N'Approved', N'251913548054', CAST(N'2023-05-16T14:25:46.903' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'9505da38-4675-4ed2-8367-0509a2981d2b', N'722300', N'251912034318', CAST(5000.00 AS Decimal(15, 2)), N'AFC6C7NUT0', N'Approved', N'251913548054', CAST(N'2023-06-12T11:04:44.600' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'60108285-bf54-4f1c-b09f-051b34fe376b', N'722300', N'251912686087', CAST(6500.00 AS Decimal(15, 2)), N'AEV5C3RGB1', N'Approved', N'251913548054', CAST(N'2023-05-31T10:18:41.577' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'7c66339c-12ac-44df-9b8b-051b99ac0eee', N'722300', N'251913651820', CAST(6500.00 AS Decimal(15, 2)), N'AFT4CD0HES', N'Approved', N'251913559285', CAST(N'2023-06-29T16:55:32.143' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'4bf86ec2-fbc2-42b3-89e0-051e821f96de', N'722300', N'251911257473', CAST(6500.00 AS Decimal(15, 2)), N'AG53CELAPV', N'Approved', N'251913548054', CAST(N'2023-07-05T09:20:50.880' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'8d123bfb-aaff-4c28-ae49-0522578c67e8', N'722300', N'251940498000', CAST(5000.00 AS Decimal(15, 2)), N'AFL8CAL3O8', N'Approved', N'251913548054', CAST(N'2023-06-21T10:52:06.207' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'61c71b40-4c84-4c07-aa82-053c71092e82', N'722300', N'251901205645', CAST(5000.00 AS Decimal(15, 2)), N'AF97C6TJLZ', N'Approved', N'251913548054', CAST(N'2023-06-09T10:55:38.230' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'c4086a64-cf6e-4f04-a719-05496c3e5b8a', N'722300', N'251913684895', CAST(5000.00 AS Decimal(15, 2)), N'AEU6C3L2X0', N'Approved', N'251913559285', CAST(N'2023-05-30T16:14:38.310' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'5d30c209-0232-44f9-843e-05571725608e', N'722300', N'251953715330', CAST(10000.00 AS Decimal(15, 2)), N'AEM0C0W6NM', N'Approved', N'251913548054', CAST(N'2023-05-22T13:46:46.873' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'43d03d2b-8cf0-4836-9e7d-057ac2daa665', N'722300', N'251970464308', CAST(5000.00 AS Decimal(15, 2)), N'AGA7CG9ILL', N'Approved', N'251913548054', CAST(N'2023-07-10T11:40:02.873' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'a38e5859-b5db-4b26-8a52-057ea881ffe7', N'722300', N'251987309728', CAST(6500.00 AS Decimal(15, 2)), N'AFR9CCB65D', N'Approved', N'251913548054', CAST(N'2023-06-27T09:06:24.257' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'84e71d82-8382-4ecf-a6db-0584c11503fc', N'722300', N'251946317775', CAST(5000.00 AS Decimal(15, 2)), N'AF60C5OXFQ', N'Approved', N'251913548054', CAST(N'2023-06-06T10:20:24.737' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'816734a2-1db1-4280-8fc6-05ab55113c16', N'722300', N'251913546464', CAST(9750.00 AS Decimal(15, 2)), N'AEU2C3JNAA', N'Approved', N'251913559285', CAST(N'2023-05-30T14:45:26.260' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'680a289f-e293-41f6-9ddd-05baad2edd38', N'722300', N'251911892000', CAST(6500.00 AS Decimal(15, 2)), N'AFJ1CA09HX', N'Approved', N'251913559285', CAST(N'2023-06-19T15:20:11.030' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'cd557221-68c8-4451-8586-05e5ce394ed0', N'722300', N'251938303545', CAST(7500.00 AS Decimal(15, 2)), N'AFJ8C9ZL3S', N'Approved', N'251913559285', CAST(N'2023-06-19T14:36:27.597' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'91402a9b-4ba3-48f2-b5cd-05f02a4a7995', N'722300', N'251911048523', CAST(5000.00 AS Decimal(15, 2)), N'AFQ7CC2DTT', N'Approved', N'251913548054', CAST(N'2023-06-26T12:06:21.427' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'e624cec1-9662-4add-8e7b-0601be7ca531', N'155329', N'251980469025', CAST(5.00 AS Decimal(15, 2)), N'AD66BJ279S', N'Approved', N'251920249797', CAST(N'2023-04-06T15:44:25.920' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'173c253e-9f28-41fb-8f3e-060840446102', N'722300', N'251913244236', CAST(5000.00 AS Decimal(15, 2)), N'AG55CEMF61', N'Approved', N'251913559285', CAST(N'2023-07-05T10:33:33.573' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'2459c936-33ca-45ed-ae19-060c73dfe10b', N'722300', N'251976212755', CAST(5000.00 AS Decimal(15, 2)), N'AFC3C7M2EB', N'Approved', N'251913559285', CAST(N'2023-06-12T09:37:05.107' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'd90cf8a5-af67-4190-8e9d-061026f10e39', N'722300', N'251913486983', CAST(6500.00 AS Decimal(15, 2)), N'AEM1C0TCKD', N'Approved', N'251913559285', CAST(N'2023-05-22T10:33:27.383' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'edd397ac-c62b-469e-9db1-061c714c034d', N'722300', N'251925685025', CAST(6500.00 AS Decimal(15, 2)), N'AFJ2CA1522', N'Approved', N'251913559285', CAST(N'2023-06-19T16:16:10.787' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'5e3edf3f-5b7b-4eac-aae6-063a865640ad', N'722300', N'251996232601', CAST(6500.00 AS Decimal(15, 2)), N'AG79CFH9CJ', N'Approved', N'251913548054', CAST(N'2023-07-07T15:43:06.237' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'abb5c02e-0799-4216-9582-064b80f022ba', N'722300', N'251919805220', CAST(5000.00 AS Decimal(15, 2)), N'AG67CF0QSB', N'Approved', N'251913548054', CAST(N'2023-07-06T11:45:50.750' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'4a17cadd-f892-450d-a748-0667caca7eb1', N'722300', N'251975185273', CAST(5000.00 AS Decimal(15, 2)), N'AFG4C96UE8', N'Approved', N'251913559285', CAST(N'2023-06-16T15:17:05.640' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'cde4e9b6-2f35-4e87-8d60-06998fe7c7d0', N'722300', N'251929214131', CAST(5000.00 AS Decimal(15, 2)), N'AF98C6TFK6', N'Approved', N'251913548054', CAST(N'2023-06-09T10:50:37.213' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'72fdeca2-2a17-4e70-b415-06abc981bbc6', N'722300', N'251920589104', CAST(6500.00 AS Decimal(15, 2)), N'AEN5C145LH', N'Approved', N'251913559285', CAST(N'2023-05-23T09:22:23.577' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'63544e83-f572-42b9-882e-06ae70d138d0', N'722300', N'251930859747', CAST(6500.00 AS Decimal(15, 2)), N'AFK2CABRF2', N'Approved', N'251913548054', CAST(N'2023-06-20T14:21:37.387' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'e7905bcd-6776-4c91-ac69-06e15844c7b0', N'722300', N'251912628785', CAST(5000.00 AS Decimal(15, 2)), N'AF26C4FAWS', N'Approved', N'251913548054', CAST(N'2023-06-02T11:19:27.200' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'6dbe9e4d-8cd7-4f86-a753-06ef4d72c442', N'722300', N'251911482878', CAST(5000.00 AS Decimal(15, 2)), N'AFQ4CC5RP8', N'Approved', N'251913559285', CAST(N'2023-06-26T16:19:20.380' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'0d9f5f24-7a3b-4b78-a402-0711d3c7d372', N'722300', N'251965605584', CAST(5000.00 AS Decimal(15, 2)), N'AEF5BXIDZF', N'Approved', N'251913548054', CAST(N'2023-05-15T15:42:32.340' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'b1823d29-6868-444f-ad83-0717822280a2', N'722300', N'251913018800', CAST(5000.00 AS Decimal(15, 2)), N'AG38CDYUV8', N'Approved', N'251913559285', CAST(N'2023-07-03T11:39:16.193' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'a711b7c0-ecc3-4ceb-9b09-073c89f3d854', N'722300', N'251915769561', CAST(6500.00 AS Decimal(15, 2)), N'AG47CEB6E5', N'Approved', N'251913559285', CAST(N'2023-07-04T12:01:55.513' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'1f62e903-4b20-495f-8e40-074d84fd5213', N'722300', N'251911420425', CAST(5000.00 AS Decimal(15, 2)), N'AF16C430C0', N'Approved', N'251913559285', CAST(N'2023-06-01T10:22:15.583' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'b93d386c-8d04-4b44-8eb7-076449ee4f60', N'722300', N'251992214120', CAST(5000.00 AS Decimal(15, 2)), N'AF88C6JA1A', N'Approved', N'251913559285', CAST(N'2023-06-08T13:55:03.970' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'40c0fdd6-67db-4c36-86e7-077f3982aa90', N'722300', N'251911843368', CAST(6500.00 AS Decimal(15, 2)), N'AF90C6Y7GA', N'Approved', N'251913548054', CAST(N'2023-06-09T15:53:17.383' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'218908c0-59bf-458e-a932-07acf9104c3e', N'722300', N'251911039833', CAST(6500.00 AS Decimal(15, 2)), N'AF16C42BD4', N'Approved', N'251913559285', CAST(N'2023-06-01T09:37:06.807' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
GO
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'e83b6953-cc0e-43a2-a96a-07b876727669', N'624626', N'251933068278', CAST(1.00 AS Decimal(15, 2)), N'AF51C5GTF9', N'Approved', N'251933068278', CAST(N'2023-06-05T16:17:14.113' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'fdb4decf-4240-4a67-8914-07c60159ff1c', N'722300', N'251911374249', CAST(6500.00 AS Decimal(15, 2)), N'AFG3C91FC9', N'Approved', N'251913548054', CAST(N'2023-06-16T09:05:47.730' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'4a69219a-743e-4a35-b9b3-07d27ad3ec14', N'722300', N'251966123052', CAST(13000.00 AS Decimal(15, 2)), N'AFT6CCY4E0', N'Approved', N'251913559285', CAST(N'2023-06-29T13:57:34.470' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'22def2b7-b227-46c4-af0e-07ffb82a8fd0', N'722300', N'251954947245', CAST(5000.00 AS Decimal(15, 2)), N'AF54C5G4E8', N'Approved', N'251913548054', CAST(N'2023-06-05T15:37:57.040' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'94019d64-9e83-4ab1-b122-080b679df564', N'722300', N'251916827006', CAST(6500.00 AS Decimal(15, 2)), N'AEQ8C2AY9G', N'Approved', N'251913548054', CAST(N'2023-05-26T15:28:19.930' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'125e4ef9-2c73-4ced-93ac-081c837078a6', N'722300', N'251939113264', CAST(5000.00 AS Decimal(15, 2)), N'AEQ1C2BPY7', N'Approved', N'251913548054', CAST(N'2023-05-26T16:16:19.057' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'9deb39b3-f2d7-4d30-a2c8-08257d380007', N'722300', N'251910273487', CAST(6500.00 AS Decimal(15, 2)), N'AEV3C3RG87', N'Approved', N'251913559285', CAST(N'2023-05-31T10:18:26.077' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'26a3158c-73e6-4a58-a14f-08366a07ca0c', N'722300', N'251980476326', CAST(5000.00 AS Decimal(15, 2)), N'AF93C6YHDV', N'Approved', N'251913548054', CAST(N'2023-06-09T16:10:34.067' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'71759ab6-074a-4d38-b9a6-084027ba827d', N'722300', N'251911812828', CAST(6500.00 AS Decimal(15, 2)), N'AEJ8BZVJB6', N'Approved', N'251913559285', CAST(N'2023-05-19T11:12:44.280' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'efd24bb1-5641-4582-8ed1-085c3c37779a', N'722300', N'251935020415', CAST(6500.00 AS Decimal(15, 2)), N'AFQ5CC5JK7', N'Approved', N'251913548054', CAST(N'2023-06-26T16:03:02.673' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'dbc26a62-ec07-4293-a368-087dd55841f5', N'722300', N'251931038471', CAST(6500.00 AS Decimal(15, 2)), N'AG56CEQ11W', N'Approved', N'251913548054', CAST(N'2023-07-05T14:27:15.043' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'4b082c76-9bcd-4ad7-8af9-089d1efc28f4', N'722300', N'251937025449', CAST(5000.00 AS Decimal(15, 2)), N'AEP0C1UJR6', N'Approved', N'251913548054', CAST(N'2023-05-25T11:08:00.013' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'6ce02d29-2add-480a-960d-08bf8c1567b4', N'722300', N'251911417317', CAST(5000.00 AS Decimal(15, 2)), N'AFE7C8DK27', N'Approved', N'251913548054', CAST(N'2023-06-14T09:44:40.577' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'3629188c-5ad2-4881-b43d-08ca599cbf80', N'722300', N'251911509989', CAST(5000.00 AS Decimal(15, 2)), N'AFT3CCYZAF', N'Approved', N'251913559285', CAST(N'2023-06-29T15:04:38.860' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'3f116575-c8d1-4e43-9a43-08d0311f8132', N'722300', N'251966561974', CAST(5000.00 AS Decimal(15, 2)), N'AEJ4BZY5JA', N'Approved', N'251913548054', CAST(N'2023-05-19T14:21:20.660' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'419bc028-936a-4e79-91d5-08d23567c03d', N'722300', N'251936930109', CAST(5000.00 AS Decimal(15, 2)), N'AF98C6SGRO', N'Approved', N'251913548054', CAST(N'2023-06-09T10:01:58.513' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'5fc20f17-9a49-4551-aa8c-08f8b9f24700', N'722300', N'251955178643', CAST(6500.00 AS Decimal(15, 2)), N'AFE6C8EJBW', N'Approved', N'251913559285', CAST(N'2023-06-14T10:38:00.340' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'07990029-3686-4b30-98d9-090a8c80e466', N'722300', N'251977568944', CAST(6500.00 AS Decimal(15, 2)), N'AFK6CACA8E', N'Approved', N'251913559285', CAST(N'2023-06-20T14:56:36.857' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'bceadd22-c6b0-4025-b585-093d64b42c38', N'722300', N'251994093306', CAST(5000.00 AS Decimal(15, 2)), N'AF63C5UGO1', N'Approved', N'251913548054', CAST(N'2023-06-06T15:47:30.410' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'14ede558-c4b0-408d-889f-097ac5e98d41', N'722300', N'251923297657', CAST(6500.00 AS Decimal(15, 2)), N'AFK8CA696K', N'Approved', N'251913548054', CAST(N'2023-06-20T08:03:06.250' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'eaafedd4-a04f-4ecc-a90a-09916716d0f4', N'722300', N'251947658738', CAST(7000.00 AS Decimal(15, 2)), N'AFN4CBADUS', N'Approved', N'251913548054', CAST(N'2023-06-23T11:40:44.187' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'345d8cba-6cdc-408a-a319-099582b4ac7d', N'722300', N'251945887806', CAST(6500.00 AS Decimal(15, 2)), N'AGA3CGCT77', N'Approved', N'251913559285', CAST(N'2023-07-10T15:01:05.310' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'5a631345-7928-410f-b5f3-09c631838c96', N'722300', N'251911669491', CAST(6500.00 AS Decimal(15, 2)), N'AGC0CGWTOW', N'Approved', N'251913559285', CAST(N'2023-07-12T09:27:39.797' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'7945c3f8-e65b-49f5-9c92-09ce558ab799', N'722300', N'251966695164', CAST(5000.00 AS Decimal(15, 2)), N'AGA5CGCKQ9', N'Approved', N'251913548054', CAST(N'2023-07-10T14:49:08.150' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'df197c45-2c12-4e2b-a946-09d3e5401adc', N'722300', N'251911054695', CAST(6500.00 AS Decimal(15, 2)), N'AFE9C8DX9T', N'Approved', N'251913548054', CAST(N'2023-06-14T10:04:35.303' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'c8d58e84-8c04-44df-a1b9-09dc7eb20aba', N'722300', N'251902521394', CAST(10250.00 AS Decimal(15, 2)), N'AFL6CAOOEW', N'Approved', N'251913548054', CAST(N'2023-06-21T15:01:50.977' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'bcbde494-5eaf-4940-8c6e-09ee37f78659', N'722300', N'251931822781', CAST(6500.00 AS Decimal(15, 2)), N'AFT8CD0EDQ', N'Approved', N'251913548054', CAST(N'2023-06-29T16:49:09.370' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'f68e7653-9f79-462d-9849-09ee65d0976d', N'155329', N'251965183828', CAST(1.00 AS Decimal(15, 2)), N'AD70BJGJVE', N'Approved', N'251920249797', CAST(N'2023-04-07T09:45:54.980' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'506eddb9-7528-4595-a010-0a50aebb57d7', N'722300', N'251924252957', CAST(5000.00 AS Decimal(15, 2)), N'AF77C64URN', N'Approved', N'251913559285', CAST(N'2023-06-07T12:09:14.230' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'3f20a56c-22a6-4be4-b575-0a568c37caeb', N'722300', N'251911210260', CAST(5000.00 AS Decimal(15, 2)), N'AEV3C3UYHH', N'Approved', N'251913548054', CAST(N'2023-05-31T14:24:41.823' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'4bb88310-23df-4a1f-8d94-0a7a90663b9d', N'722300', N'251940127699', CAST(5000.00 AS Decimal(15, 2)), N'AFE4C8D8SK', N'Approved', N'251913548054', CAST(N'2023-06-14T09:26:06.097' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'697977e7-69d9-4c54-8d6b-0a8a5e4d6a86', N'722300', N'251915782363', CAST(6500.00 AS Decimal(15, 2)), N'AEI2BZMDOW', N'Approved', N'251913559285', CAST(N'2023-05-18T14:36:35.907' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'30648269-3a40-420a-ac81-0a90bf38f2e1', N'722300', N'251915134119', CAST(6500.00 AS Decimal(15, 2)), N'AG71CFFXKB', N'Approved', N'251913548054', CAST(N'2023-07-07T14:23:59.940' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'08b8c46e-7eeb-4835-b061-0adcce3b17a8', N'155329', N'251980469025', CAST(1.00 AS Decimal(15, 2)), N'AD78BJGIA4', N'Approved', N'251920249797', CAST(N'2023-04-07T09:42:55.600' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'dcb42dfa-5b80-49b2-b78d-0b1d20ad9d8f', N'722300', N'251911517365', CAST(6500.00 AS Decimal(15, 2)), N'AFU4CD75W0', N'Approved', N'251913548054', CAST(N'2023-06-30T11:20:57.017' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'a7ed4c32-5006-4d86-87b5-0b382271c1e4', N'722300', N'251989992278', CAST(5000.00 AS Decimal(15, 2)), N'AFN8CBCR5Q', N'Approved', N'251913548054', CAST(N'2023-06-23T14:45:34.600' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'0d2d0611-b973-4a90-a581-0b3e35b8fc62', N'722300', N'251911424087', CAST(5000.00 AS Decimal(15, 2)), N'AFL0CAPID2', N'Approved', N'251913559285', CAST(N'2023-06-21T15:50:50.630' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'04c6266a-1dd8-4efe-9b84-0b57e05cdf6b', N'722300', N'251911368506', CAST(6500.00 AS Decimal(15, 2)), N'AFJ4C9ZUXU', N'Approved', N'251913548054', CAST(N'2023-06-19T14:55:18.283' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'225e8d9f-7634-43bb-8392-0b5813759bcc', N'722300', N'251928689476', CAST(6500.00 AS Decimal(15, 2)), N'AFR6CCGTUW', N'Approved', N'251913559285', CAST(N'2023-06-27T16:15:45.647' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'70b03254-713e-4ea6-9889-0b6350f13b22', N'722300', N'251911807656', CAST(6500.00 AS Decimal(15, 2)), N'AEO9C1KX0D', N'Approved', N'251913548054', CAST(N'2023-05-24T14:14:57.407' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'94a83635-87f2-43b7-819c-0b96bcad1992', N'722300', N'251911007686', CAST(6500.00 AS Decimal(15, 2)), N'AEG1BXTYXL', N'Approved', N'251913548054', CAST(N'2023-05-16T10:21:36.523' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'8348f21a-4f0e-45c6-a03d-0bbd6890a755', N'722300', N'251911231244', CAST(6500.00 AS Decimal(15, 2)), N'AFR3CCD939', N'Approved', N'251913559285', CAST(N'2023-06-27T11:35:36.717' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'79a85dae-de68-4790-a529-0bc4432de803', N'722300', N'251915742602', CAST(6500.00 AS Decimal(15, 2)), N'AFL9CALY1L', N'Approved', N'251913548054', CAST(N'2023-06-21T11:40:35.527' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'e6e85dbb-1794-46a3-97c1-0bc4daadf735', N'722300', N'251983203641', CAST(5000.00 AS Decimal(15, 2)), N'AF53C5FA5V', N'Approved', N'251913559285', CAST(N'2023-06-05T14:53:10.263' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'76599319-77c1-47ae-9878-0be74b0e17af', N'722300', N'251911341127', CAST(5000.00 AS Decimal(15, 2)), N'AFJ1C9W6BB', N'Approved', N'251913559285', CAST(N'2023-06-19T10:36:04.767' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'2ca51f91-bf12-4b4f-9de0-0c18c8cf21fe', N'722300', N'251918527383', CAST(6500.00 AS Decimal(15, 2)), N'AG40CE8VN2', N'Approved', N'251913559285', CAST(N'2023-07-04T09:46:15.083' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'29315083-1dca-45fe-9c84-0c432395e567', N'722300', N'251912430217', CAST(5000.00 AS Decimal(15, 2)), N'AFL0CAP2I8', N'Approved', N'251913548054', CAST(N'2023-06-21T15:25:44.057' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'df75981f-e905-4ca8-9b9f-0c43f2ccd70a', N'722300', N'251967710052', CAST(6500.00 AS Decimal(15, 2)), N'AFR0CCC6L2', N'Approved', N'251913548054', CAST(N'2023-06-27T10:20:44.220' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'2bbac35e-c8d2-473b-b8fb-0c464f26cc36', N'722300', N'251909523769', CAST(6500.00 AS Decimal(15, 2)), N'AFL3CAK1YV', N'Approved', N'251913548054', CAST(N'2023-06-21T09:51:17.310' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'a8eb37ae-0b42-46a5-bdf5-0c70dd388523', N'722300', N'251918761253', CAST(6500.00 AS Decimal(15, 2)), N'AFD0C82SPK', N'Approved', N'251913559285', CAST(N'2023-06-13T11:54:18.853' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'6e0f1f91-be80-45b4-b4ed-0ccbe9323259', N'722300', N'251913173863', CAST(6500.00 AS Decimal(15, 2)), N'AFE3C8FEB3', N'Approved', N'251913548054', CAST(N'2023-06-14T11:24:11.113' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'a3bb7203-17d0-472b-8a36-0cdbb3bc2fd2', N'722300', N'251904061570', CAST(7500.00 AS Decimal(15, 2)), N'AFJ9C9X9LZ', N'Approved', N'251913559285', CAST(N'2023-06-19T11:39:47.773' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'2b149b58-5bce-4384-8826-0cdd26f6654a', N'722300', N'251953978553', CAST(5000.00 AS Decimal(15, 2)), N'AF98C6S35E', N'Approved', N'251913548054', CAST(N'2023-06-09T09:40:39.923' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'25f1f9b5-cc36-41f3-8768-0cde233d6ee4', N'722300', N'251961119757', CAST(6500.00 AS Decimal(15, 2)), N'AFR7CCD4H9', N'Approved', N'251913548054', CAST(N'2023-06-27T11:26:07.917' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'fa31ed0d-fe2d-483b-980d-0cdf9be658c8', N'624626', N'251900650395', CAST(1.00 AS Decimal(15, 2)), N'AF56C5GWF6', N'Approved', N'251933068278', CAST(N'2023-06-05T16:21:51.620' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'0951fa20-cade-4be8-8c45-0d2f4fae0720', N'722300', N'251913083908', CAST(6500.00 AS Decimal(15, 2)), N'AFG4C91804', N'Approved', N'251913548054', CAST(N'2023-06-16T08:47:47.840' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'0a4a768a-a558-4465-8650-0d310f6a0727', N'722300', N'251911447018', CAST(6500.00 AS Decimal(15, 2)), N'AFN5CB892X', N'Approved', N'251913548054', CAST(N'2023-06-23T09:26:54.343' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'2ea04e01-bf04-446e-a7f8-0d36eba9a4da', N'722300', N'251911885900', CAST(5000.00 AS Decimal(15, 2)), N'AGB0CGP3OK', N'Approved', N'251913559285', CAST(N'2023-07-11T13:59:57.537' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'25124ccd-195e-4fa6-af74-0d43beb5a827', N'722300', N'251912253396', CAST(6500.00 AS Decimal(15, 2)), N'AFC0C7LYCO', N'Approved', N'251913559285', CAST(N'2023-06-12T09:30:49.060' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'7de57ea8-1c43-49ad-8e0e-0d52597484ee', N'722300', N'251979847321', CAST(5000.00 AS Decimal(15, 2)), N'AF64C5QOKM', N'Approved', N'251913559285', CAST(N'2023-06-06T11:47:19.173' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'ee583660-7c86-4c7d-84c8-0d6346e5a286', N'722300', N'251909570474', CAST(6500.00 AS Decimal(15, 2)), N'AG39CE1UON', N'Approved', N'251913548054', CAST(N'2023-07-03T15:23:44.883' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'514a508e-cd4b-4716-8813-0d824a97d3da', N'722300', N'251954737553', CAST(6500.00 AS Decimal(15, 2)), N'AFK2CABT1E', N'Approved', N'251913559285', CAST(N'2023-06-20T14:24:53.640' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'8169b76c-07e3-490f-a861-0d8dec3348e6', N'722300', N'251945755458', CAST(5000.00 AS Decimal(15, 2)), N'AEG8BXV81E', N'Approved', N'251922755677', CAST(N'2023-05-16T10:38:13.837' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'3e797df4-17b4-42af-a868-0db4a71f985a', N'722300', N'251911659092', CAST(5000.00 AS Decimal(15, 2)), N'AEI3BZO5QR', N'Approved', N'251913548054', CAST(N'2023-05-18T16:32:22.437' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'4fd2ce34-831d-4773-a419-0dc65f318ad1', N'722300', N'251906976678', CAST(5000.00 AS Decimal(15, 2)), N'AFQ9CC5R8F', N'Approved', N'251913548054', CAST(N'2023-06-26T16:17:34.547' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'2f3a6fa1-09bc-4476-8b89-0dda57a3e07d', N'722300', N'251967608317', CAST(6500.00 AS Decimal(15, 2)), N'AFJ8C9V2K4', N'Approved', N'251913559285', CAST(N'2023-06-19T09:25:57.150' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'c12d8a94-c403-402a-90a0-0dec6bfef135', N'722300', N'251912503373', CAST(5000.00 AS Decimal(15, 2)), N'AFN1CB8WIP', N'Approved', N'251913548054', CAST(N'2023-06-23T10:10:45.080' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'ed8ba098-0490-4cdf-b90e-0df92afcaacc', N'722300', N'251966808349', CAST(6500.00 AS Decimal(15, 2)), N'AFF8C8SH2G', N'Approved', N'251913559285', CAST(N'2023-06-15T11:50:31.000' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'be7ad2ac-002f-48bb-bbfc-0dfb6b3dd059', N'722300', N'251925418290', CAST(6500.00 AS Decimal(15, 2)), N'AFL4CAKNJK', N'Approved', N'251913548054', CAST(N'2023-06-21T10:26:26.470' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'0dff8dad-6800-49b3-b341-0e320f0a3bc4', N'722300', N'251905048511', CAST(6500.00 AS Decimal(15, 2)), N'AG32CDXR84', N'Approved', N'251913548054', CAST(N'2023-07-03T10:28:17.163' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'b1d0cb35-5699-4d93-bb86-0e33267afb9f', N'722300', N'251904389935', CAST(6500.00 AS Decimal(15, 2)), N'AFK5CA99RD', N'Approved', N'251913548054', CAST(N'2023-06-20T11:22:44.053' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'60b857a1-856f-425d-8a1f-0e3cc6e94cf5', N'722300', N'251911232047', CAST(6500.00 AS Decimal(15, 2)), N'AG39CE3D8T', N'Approved', N'251913559285', CAST(N'2023-07-03T17:11:50.413' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'f0f15780-9d2d-459a-90dc-0e5e32a9feef', N'722300', N'251946679456', CAST(5000.00 AS Decimal(15, 2)), N'AG79CFHU2X', N'Approved', N'251913548054', CAST(N'2023-07-07T16:15:57.533' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'3ecb129d-a9f7-46a8-8dcb-0ec40cbc0c59', N'722300', N'251911902015', CAST(13000.00 AS Decimal(15, 2)), N'AFL2CAPHRQ', N'Approved', N'251913548054', CAST(N'2023-06-21T15:50:46.223' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'e0d9de77-9bde-490b-ae3d-0ee0bf2bafa2', N'722300', N'251929124710', CAST(6500.00 AS Decimal(15, 2)), N'AFJ8C9X9QY', N'Approved', N'251913548054', CAST(N'2023-06-19T11:40:21.670' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'81925897-2796-4df9-ba8c-0efaff0ce331', N'722300', N'251911461826', CAST(5000.00 AS Decimal(15, 2)), N'AF58C5CIC4', N'Approved', N'251913559285', CAST(N'2023-06-05T11:53:18.933' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'57fb1930-4f81-42fc-a5c5-0f1011051f45', N'722300', N'251973338167', CAST(8000.00 AS Decimal(15, 2)), N'AFG0C93VF0', N'Approved', N'251913559285', CAST(N'2023-06-16T11:36:36.163' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'b0651ac5-f911-4d20-9fa5-0f46dc014875', N'722300', N'251914362742', CAST(6500.00 AS Decimal(15, 2)), N'AGA5CGCOH9', N'Approved', N'251913548054', CAST(N'2023-07-10T14:53:38.463' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'a46c6c16-c714-4593-95fd-0f4d49089fe2', N'722300', N'251947965145', CAST(13000.00 AS Decimal(15, 2)), N'AFD0C830VG', N'Approved', N'251913559285', CAST(N'2023-06-13T12:06:43.143' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'22167296-8bfa-46fb-a8cc-0f8b6f63db55', N'722300', N'251942201209', CAST(5000.00 AS Decimal(15, 2)), N'AFG3C91JQB', N'Approved', N'251913559285', CAST(N'2023-06-16T09:15:48.523' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'd967d149-72a2-42d2-8937-0faddede5506', N'722300', N'251911647846', CAST(6500.00 AS Decimal(15, 2)), N'AEU3C3FPSF', N'Approved', N'251913548054', CAST(N'2023-05-30T10:17:23.267' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'5eae21ca-6d72-4e80-a491-0fb104b11bd5', N'722300', N'251991181873', CAST(6500.00 AS Decimal(15, 2)), N'AG60CF5JLS', N'Approved', N'251913548054', CAST(N'2023-07-06T17:02:03.713' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'c6bd29ff-baea-4253-969b-0fc3e7105c1c', N'722300', N'251919804354', CAST(6500.00 AS Decimal(15, 2)), N'AFK8CAC3P6', N'Approved', N'251913548054', CAST(N'2023-06-20T14:44:29.603' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'4bfa4b85-242b-470b-a4fb-10086129bdee', N'722300', N'251913381939', CAST(5000.00 AS Decimal(15, 2)), N'AFG4C93HGW', N'Approved', N'251913548054', CAST(N'2023-06-16T11:12:46.967' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'0c678cbc-f8eb-4bc9-bd06-100e598be718', N'722300', N'251978165312', CAST(5000.00 AS Decimal(15, 2)), N'AG37CE2J9V', N'Approved', N'251913559285', CAST(N'2023-07-03T16:09:18.883' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'5ff26e54-8905-4fec-8eda-101074ff85dd', N'722300', N'251920000802', CAST(5000.00 AS Decimal(15, 2)), N'AEV1C3S9FT', N'Approved', N'251913559285', CAST(N'2023-05-31T11:05:30.103' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'b1d36cbf-205f-4ced-a953-1032b4527e60', N'722300', N'251913999936', CAST(6500.00 AS Decimal(15, 2)), N'AGB6CGR0T2', N'Approved', N'251913548054', CAST(N'2023-07-11T15:50:03.080' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'5eb3a306-6932-4a3e-9476-103adcc41c81', N'722300', N'251921508297', CAST(5000.00 AS Decimal(15, 2)), N'AF17C47XDN', N'Approved', N'251913559285', CAST(N'2023-06-01T16:05:09.623' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'0d3672a7-b381-49a1-81d7-105f31a31d58', N'722300', N'251924542858', CAST(6500.00 AS Decimal(15, 2)), N'AEP0C1WQ54', N'Approved', N'251913548054', CAST(N'2023-05-25T13:47:27.800' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'985bd341-7917-4114-9c47-1083854ac5a9', N'722300', N'251913573989', CAST(5000.00 AS Decimal(15, 2)), N'AFN5CB7WIP', N'Approved', N'251913548054', CAST(N'2023-06-23T09:01:11.640' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'1bc7ab5e-3684-44cb-a839-109be228f9db', N'722300', N'251911625738', CAST(6500.00 AS Decimal(15, 2)), N'AFK1CACTDF', N'Approved', N'251913559285', CAST(N'2023-06-20T15:28:23.307' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'372ca81e-5da3-4c14-abb0-109dba516043', N'722300', N'251973745272', CAST(5000.00 AS Decimal(15, 2)), N'AEJ8BZYJ0O', N'Approved', N'251913548054', CAST(N'2023-05-19T14:46:14.347' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'5149d40d-5b72-417d-b4e7-10a20f6ddf9d', N'722300', N'251961189864', CAST(5000.00 AS Decimal(15, 2)), N'AG37CDXY5F', N'Approved', N'251913548054', CAST(N'2023-07-03T10:40:17.247' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'41553bcd-41eb-410c-80ba-10bb3b3b1b41', N'722300', N'251930100083', CAST(6500.00 AS Decimal(15, 2)), N'AFG2C96C1M', N'Approved', N'251913548054', CAST(N'2023-06-16T14:42:47.770' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'9888a49f-c13d-4926-a96e-10d7b9ed1f01', N'722300', N'251913156630', CAST(9750.00 AS Decimal(15, 2)), N'AFR6CCCTNS', N'Approved', N'251913559285', CAST(N'2023-06-27T11:04:34.803' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'35c60ce8-29b0-4f01-858b-110b6b8b6807', N'722300', N'251913696886', CAST(6500.00 AS Decimal(15, 2)), N'AG76CFFG08', N'Approved', N'251913548054', CAST(N'2023-07-07T13:51:30.933' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'20a67d78-df97-478f-a530-1113d006a213', N'722300', N'251911405891', CAST(5000.00 AS Decimal(15, 2)), N'AEV0C3UGWC', N'Approved', N'251913559285', CAST(N'2023-05-31T13:47:02.263' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'c7883238-aa1a-4e52-be56-1120cd651c72', N'722300', N'251911974689', CAST(6500.00 AS Decimal(15, 2)), N'AF14C42FM4', N'Approved', N'251913559285', CAST(N'2023-06-01T09:45:26.023' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'6b39e0af-77be-4b89-a4c3-113975bb47b9', N'722300', N'251922122747', CAST(6500.00 AS Decimal(15, 2)), N'AFR1CCGW3L', N'Approved', N'251913559285', CAST(N'2023-07-12T14:41:03.897' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
INSERT [dbo].[MerchantAppTXN] ([Id], [Shortcode], [Phone], [Amount], [TransactionId], [Status], [SalersPhone], [TransactionEndDate], [InsertDate], [UpdateDate], [InsertUser], [UpdateUser]) VALUES (N'7a505bfa-5363-4c45-ae40-113ef115e144', N'722300', N'251955938835', CAST(6500.00 AS Decimal(15, 2)), N'AFN1CBCOHP', N'Approved', N'251913548054', CAST(N'2023-07-12T14:41:03.897' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), CAST(N'2023-07-19T03:59:15.760' AS DateTime), N'system', N'system')
GO
INSERT [dbo].[SysPar] ([GLCodeLen], [SLCodeLen], [MinPWDLen], [MinLoginIdLen], [TotalCapital]) VALUES (5, 8, 6, 2, 6000000000.0000)
GO
INSERT [dbo].[SysSecurityParm] ([LoginIdMinLength], [PasswordMinLength], [PasswordMustHaveDigit], [PasswordMustHaveLowerCase], [PasswordMustHaveUpperCase], [PasswordMustHaveSpecialChar], [AllowedUnsuccessfulAttempts], [PasswordInterval], [PasswordHistory], [UpdateUser], [UpdateDate]) VALUES (2, 6, 1, 1, 1, 1, 3, 0, 2, N'eph', CAST(N'2011-01-20T15:34:01.000' AS DateTime))
GO
ALTER TABLE [dbo].[MerchantAppMerchantInfo] ADD  CONSTRAINT [DF_MerchantInfo_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[MerchantAppTXN] ADD  CONSTRAINT [DF_MerchantAppTXN_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  StoredProcedure [dbo].[getActiveLoanId]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getActiveLoanId]
as
begin
select   loanBasic.LoanId,CONCAT(LoanId,' - ' collate Latin1_General_CI_AS,cust.FirstName,' ' collate Latin1_General_CI_AS,cust.MiddleName) as Fullname from LoanBasicInformation as loanBasic , LoanMember as loanMemb, Customer as cust  where loanBasic.Status = 'Active' and loanBasic.EmployeeId = loanMemb.EmployeeId and cust.CustomerID = loanMemb.EmployeeId

end
GO
/****** Object:  StoredProcedure [dbo].[getBranchNames]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[getBranchNames]
as
begin
select BranchName FROM Branch
end
GO
/****** Object:  StoredProcedure [dbo].[getCollateralFullName]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getCollateralFullName]
  as
  SELECT EmployeeId,CONCAT(EmployeeId,' - ',FirstName,'  ', MiddleName,'  ', LastName) AS FullName FROM Collateral
GO
/****** Object:  StoredProcedure [dbo].[getCustomerFullName]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE procedure [dbo].[getCustomerFullName] 
  as
  SELECT CustomerID,CONCAT(CustomerID,' - ',FirstName,'  ', MiddleName) AS FullName FROM Customer
GO
/****** Object:  StoredProcedure [dbo].[getEmployeeFullName]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getEmployeeFullName]
as
SELECT EmployeeId,CONCAT(EmployeeId,' - ',FirstName,'  ', MiddleName) AS FullName FROM Customer,LoanMember where Customer.CustomerID = LoanMember.CustomerId
GO
/****** Object:  StoredProcedure [dbo].[getEmployeeIdToLoanStatement]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getEmployeeIdToLoanStatement]
as 
BEGIN
select EmployeeId, LoanId, CONCAT(EmployeeId,' - ', FirstName,' ' ,LastName) as Fullname from LoanBasicInformation,Customer
where Customer.CustomerID=LoanBasicInformation.EmployeeId
END
GO
/****** Object:  StoredProcedure [dbo].[getLastLoanBasicInformationId]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[getLastLoanBasicInformationId] 
as
begin
SELECT TOP 1 Id, CONCAT('Ln - ' , Id+1) as NextLoanId FROM LoanBasicInformation ORDER BY Id DESC 
end
GO
/****** Object:  StoredProcedure [dbo].[getLoanIdToGrant]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getLoanIdToGrant]
as
begin
select   loanBasic.LoanId,CONCAT(LoanId,' - ' collate Latin1_General_CI_AS,cust.FirstName,' ' collate Latin1_General_CI_AS,cust.MiddleName) as Fullname from LoanBasicInformation as loanBasic , LoanMember as loanMemb, Customer as cust  where loanBasic.Status = 'Pending' and loanBasic.EmployeeId = loanMemb.EmployeeId and cust.CustomerID = loanMemb.EmployeeId
end
GO
/****** Object:  StoredProcedure [dbo].[getLoanInformationForRepayment]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getLoanInformationForRepayment]
as
begin
select Id,LoanId,EmployeeId,CollateralId,Interest,InterestAmount,PrincipalAmount,RepaymentAmount from LoanBasicInformation where Status = 'Active'
end
GO
/****** Object:  StoredProcedure [dbo].[getLoanInformations]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[getLoanInformations]
as
Begin
--SELECT
--   T1.Code, T2.Code
--FROM
--   (SELECT DISTINCT Code FROM Table1) T1
--   FULL OUTER JOIN
--   (SELECT DISTINCT Code FROM Table2) T2
--              ON T1.Code = T2.Code



 Select LoanAmount,RepaymentAmount,LoanPeriod,Interest, CONCAT(LoanAmount,' Birr') AS LoanAmountInfo,CONCAT(RepaymentAmount,' Birr') AS RepaymentAmountInfo,CONCAT(LoanPeriod,' Months') AS LoanPeriodInfo,CONCAT(Interest,' %') AS InterestInfo from LoanRuleSetup
End
GO
/****** Object:  StoredProcedure [dbo].[sp_DistrictIDToBaranch]    Script Date: 9/20/2023 1:56:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_DistrictIDToBaranch]
as 
 begin 
 select ID,Name AS DISTRICTiNFO  from District 
 end
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[56] 4[9] 2[12] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "LoanBasicInformation"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 419
               Right = 298
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "LoanRepayment"
            Begin Extent = 
               Top = 3
               Left = 385
               Bottom = 446
               Right = 562
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LoanStatementView'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'LoanStatementView'
GO
USE [master]
GO
ALTER DATABASE [MerchantDashboard] SET  READ_WRITE 
GO
