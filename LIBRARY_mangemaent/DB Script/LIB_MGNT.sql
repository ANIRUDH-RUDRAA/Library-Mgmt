USE [master]
GO
/****** Object:  Database [Library_management]    Script Date: 12/29/2024 9:55:39 PM ******/
CREATE DATABASE [Library_management]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Library_management', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Library_management.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Library_management_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Library_management_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Library_management] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Library_management].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Library_management] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Library_management] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Library_management] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Library_management] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Library_management] SET ARITHABORT OFF 
GO
ALTER DATABASE [Library_management] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Library_management] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Library_management] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Library_management] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Library_management] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Library_management] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Library_management] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Library_management] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Library_management] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Library_management] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Library_management] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Library_management] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Library_management] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Library_management] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Library_management] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Library_management] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Library_management] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Library_management] SET RECOVERY FULL 
GO
ALTER DATABASE [Library_management] SET  MULTI_USER 
GO
ALTER DATABASE [Library_management] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Library_management] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Library_management] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Library_management] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Library_management] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Library_management] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Library_management', N'ON'
GO
ALTER DATABASE [Library_management] SET QUERY_STORE = ON
GO
ALTER DATABASE [Library_management] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Library_management]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 12/29/2024 9:55:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
	[bookcode] [varchar](100) NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK__Book__3213E83F4488E341] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student]    Script Date: 12/29/2024 9:55:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[mobile] [varchar](20) NULL,
 CONSTRAINT [PK__student__3213E83FB0D70484] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[student_book_issue]    Script Date: 12/29/2024 9:55:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[student_book_issue](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Student_id] [int] NOT NULL,
	[Issue_date] [datetime2](7) NOT NULL,
	[return_date] [datetime2](7) NULL,
	[type] [varchar](100) NOT NULL,
	[book_id] [int] NOT NULL,
 CONSTRAINT [PK__student___3213E83F57BBACEE] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[student_book_issue]  WITH CHECK ADD FOREIGN KEY([book_id])
REFERENCES [dbo].[Book] ([id])
GO
ALTER TABLE [dbo].[student_book_issue]  WITH CHECK ADD FOREIGN KEY([Student_id])
REFERENCES [dbo].[student] ([id])
GO
/****** Object:  StoredProcedure [dbo].[BookIssueData]    Script Date: 12/29/2024 9:55:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create  proc [dbo].[BookIssueData] 
as 
begin 

select  j.name ,format (u.issue_date  ,'dd MMM yyyy')as issue_date,format (u.return_date ,'dd MMM yyyy')as return_date , (v.name)as bookname,u.type    from student_book_issue u 
join book v on v.id=u.book_id 
join student j  on j.id=u.student_id 

end 
GO
/****** Object:  StoredProcedure [dbo].[dashbordproc]    Script Date: 12/29/2024 9:55:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[dashbordproc] 
as 
begin 

SELECT 
    (SELECT COUNT(*) FROM BOOK) AS book_count,
    (SELECT COUNT(*) FROM student_book_issue WHERE return_date IS NULL) AS issue_count,
    (SELECT COUNT(*) FROM student) AS student_count;

	end 
GO
USE [master]
GO
ALTER DATABASE [Library_management] SET  READ_WRITE 
GO
