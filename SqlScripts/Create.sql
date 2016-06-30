USE [master]
GO
/****** Object:  Database [BYSDN]    Script Date: 6/30/2016 4:18:12 PM ******/
CREATE DATABASE [BYSDN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BYSDN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BYSDN.mdf' , SIZE = 17408KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'BYSDN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\BYSDN_log.ldf' , SIZE = 9216KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [BYSDN] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BYSDN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BYSDN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BYSDN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BYSDN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BYSDN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BYSDN] SET ARITHABORT OFF 
GO
ALTER DATABASE [BYSDN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [BYSDN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BYSDN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BYSDN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BYSDN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BYSDN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BYSDN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BYSDN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BYSDN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BYSDN] SET  DISABLE_BROKER 
GO
ALTER DATABASE [BYSDN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BYSDN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BYSDN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BYSDN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BYSDN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BYSDN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BYSDN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BYSDN] SET RECOVERY FULL 
GO
ALTER DATABASE [BYSDN] SET  MULTI_USER 
GO
ALTER DATABASE [BYSDN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BYSDN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BYSDN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BYSDN] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [BYSDN] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'BYSDN', N'ON'
GO
USE [BYSDN]
GO
/****** Object:  User [FAREAST\v-pauwan]    Script Date: 6/30/2016 4:18:12 PM ******/
CREATE USER [FAREAST\v-pauwan] FOR LOGIN [FAREAST\v-pauwan] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [FAREAST\v-pauwan]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [FAREAST\v-pauwan]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [FAREAST\v-pauwan]
GO
/****** Object:  Table [dbo].[Table_Answer]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Answer](
	[ID] [uniqueidentifier] NOT NULL,
	[QuestionID] [uniqueidentifier] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Publisher] [uniqueidentifier] NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Table_Answer] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_Attachments]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Attachments](
	[ID] [uniqueidentifier] NOT NULL,
	[QuestionID] [uniqueidentifier] NOT NULL,
	[FileName] [nvarchar](127) NOT NULL,
	[FileSize] [nvarchar](63) NOT NULL,
 CONSTRAINT [PK_Table_Attachments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_BBSItem]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_BBSItem](
	[ID] [uniqueidentifier] NOT NULL,
	[BBSTypeName] [nvarchar](127) NOT NULL,
 CONSTRAINT [PK_BBSItem] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_BBSManager]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_BBSManager](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BBSTypeId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Table_BBSManager] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_Blog]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Blog](
	[ID] [uniqueidentifier] NOT NULL,
	[Status] [int] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Date] [datetime] NOT NULL,
	[Publisher] [uniqueidentifier] NOT NULL,
	[BlogItemId] [uniqueidentifier] NOT NULL,
	[Title] [nvarchar](255) NULL,
 CONSTRAINT [PK_Table_Blog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_BlogAttachments]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_BlogAttachments](
	[ID] [uniqueidentifier] NOT NULL,
	[BlogID] [uniqueidentifier] NOT NULL,
	[FileName] [nvarchar](127) NOT NULL,
	[FileSize] [nvarchar](63) NOT NULL,
 CONSTRAINT [PK_Table_BlogAttachments] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_BlogItem]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_BlogItem](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](2047) NOT NULL,
 CONSTRAINT [PK_Table_BlogItem] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_BlogManager]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_BlogManager](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[BlogTypeId] [uniqueidentifier] NOT NULL,
	[UserId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Table_BlogManager] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_BlogReply]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_BlogReply](
	[ID] [uniqueidentifier] NOT NULL,
	[BlogID] [uniqueidentifier] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Publisher] [uniqueidentifier] NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Table_BlogReply] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_LogEntity]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_LogEntity](
	[ID] [uniqueidentifier] NOT NULL,
	[OperationTypeID] [uniqueidentifier] NOT NULL,
	[LogType] [nvarchar](31) NOT NULL,
	[OriginValue] [nvarchar](511) NULL,
	[NewValue] [nvarchar](511) NOT NULL,
 CONSTRAINT [PK_Table_LogEntity] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_OperationLog]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_OperationLog](
	[ID] [uniqueidentifier] NOT NULL,
	[Date] [datetime] NOT NULL,
	[LogEntityID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Table_OperationLog] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_OperationType]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_OperationType](
	[ID] [uniqueidentifier] NOT NULL,
	[Type] [nvarchar](127) NOT NULL,
 CONSTRAINT [PK_Table_OperationType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_Question]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_Question](
	[ID] [uniqueidentifier] NOT NULL,
	[Tittle] [nvarchar](254) NOT NULL,
	[Tags] [nvarchar](254) NULL,
	[Date] [datetime] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Publisher] [uniqueidentifier] NOT NULL,
	[TypeId] [uniqueidentifier] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Table_Question] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_SubBlogReply]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table_SubBlogReply](
	[ID] [uniqueidentifier] NOT NULL,
	[ReplyID] [uniqueidentifier] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Publisher] [uniqueidentifier] NOT NULL,
	[Date] [datetime] NOT NULL,
 CONSTRAINT [PK_Table_SubBlogReply] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Table_User]    Script Date: 6/30/2016 4:18:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Table_User](
	[ID] [uniqueidentifier] NOT NULL,
	[Name] [varchar](127) NOT NULL,
	[Sexy] [bit] NOT NULL,
	[Date] [datetime] NOT NULL,
	[Comments] [varchar](511) NULL,
	[Photo] [varchar](511) NULL,
	[Rate] [int] NULL,
 CONSTRAINT [PK_Table_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Table_Answer]  WITH CHECK ADD  CONSTRAINT [FK_Table_Answer_Table_Question] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Table_Question] ([ID])
GO
ALTER TABLE [dbo].[Table_Answer] CHECK CONSTRAINT [FK_Table_Answer_Table_Question]
GO
ALTER TABLE [dbo].[Table_Answer]  WITH CHECK ADD  CONSTRAINT [FK_Table_Answer_Table_User] FOREIGN KEY([Publisher])
REFERENCES [dbo].[Table_User] ([ID])
GO
ALTER TABLE [dbo].[Table_Answer] CHECK CONSTRAINT [FK_Table_Answer_Table_User]
GO
ALTER TABLE [dbo].[Table_Attachments]  WITH CHECK ADD  CONSTRAINT [FK_Table_Attachments_Table_Question] FOREIGN KEY([QuestionID])
REFERENCES [dbo].[Table_Question] ([ID])
GO
ALTER TABLE [dbo].[Table_Attachments] CHECK CONSTRAINT [FK_Table_Attachments_Table_Question]
GO
ALTER TABLE [dbo].[Table_BBSManager]  WITH CHECK ADD  CONSTRAINT [FK_Table_BBSManager_Table_BBSItem] FOREIGN KEY([BBSTypeId])
REFERENCES [dbo].[Table_BBSItem] ([ID])
GO
ALTER TABLE [dbo].[Table_BBSManager] CHECK CONSTRAINT [FK_Table_BBSManager_Table_BBSItem]
GO
ALTER TABLE [dbo].[Table_BBSManager]  WITH CHECK ADD  CONSTRAINT [FK_Table_BBSManager_Table_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Table_User] ([ID])
GO
ALTER TABLE [dbo].[Table_BBSManager] CHECK CONSTRAINT [FK_Table_BBSManager_Table_User]
GO
ALTER TABLE [dbo].[Table_Blog]  WITH CHECK ADD  CONSTRAINT [FK_Table_Blog_Table_BlogItem] FOREIGN KEY([BlogItemId])
REFERENCES [dbo].[Table_BlogItem] ([ID])
GO
ALTER TABLE [dbo].[Table_Blog] CHECK CONSTRAINT [FK_Table_Blog_Table_BlogItem]
GO
ALTER TABLE [dbo].[Table_Blog]  WITH CHECK ADD  CONSTRAINT [FK_Table_Blog_Table_User] FOREIGN KEY([Publisher])
REFERENCES [dbo].[Table_User] ([ID])
GO
ALTER TABLE [dbo].[Table_Blog] CHECK CONSTRAINT [FK_Table_Blog_Table_User]
GO
ALTER TABLE [dbo].[Table_BlogAttachments]  WITH CHECK ADD  CONSTRAINT [FK_Table_BlogAttachments_Table_Blog] FOREIGN KEY([BlogID])
REFERENCES [dbo].[Table_Blog] ([ID])
GO
ALTER TABLE [dbo].[Table_BlogAttachments] CHECK CONSTRAINT [FK_Table_BlogAttachments_Table_Blog]
GO
ALTER TABLE [dbo].[Table_BlogManager]  WITH CHECK ADD  CONSTRAINT [FK_Table_BlogManager_Table_BlogItem] FOREIGN KEY([BlogTypeId])
REFERENCES [dbo].[Table_BlogItem] ([ID])
GO
ALTER TABLE [dbo].[Table_BlogManager] CHECK CONSTRAINT [FK_Table_BlogManager_Table_BlogItem]
GO
ALTER TABLE [dbo].[Table_BlogManager]  WITH CHECK ADD  CONSTRAINT [FK_Table_BlogManager_Table_User] FOREIGN KEY([UserId])
REFERENCES [dbo].[Table_User] ([ID])
GO
ALTER TABLE [dbo].[Table_BlogManager] CHECK CONSTRAINT [FK_Table_BlogManager_Table_User]
GO
ALTER TABLE [dbo].[Table_BlogReply]  WITH CHECK ADD  CONSTRAINT [FK_Table_BlogReply_Table_Blog] FOREIGN KEY([BlogID])
REFERENCES [dbo].[Table_Blog] ([ID])
GO
ALTER TABLE [dbo].[Table_BlogReply] CHECK CONSTRAINT [FK_Table_BlogReply_Table_Blog]
GO
ALTER TABLE [dbo].[Table_BlogReply]  WITH CHECK ADD  CONSTRAINT [FK_Table_BlogReply_Table_User] FOREIGN KEY([Publisher])
REFERENCES [dbo].[Table_User] ([ID])
GO
ALTER TABLE [dbo].[Table_BlogReply] CHECK CONSTRAINT [FK_Table_BlogReply_Table_User]
GO
ALTER TABLE [dbo].[Table_LogEntity]  WITH CHECK ADD  CONSTRAINT [FK_Table_LogEntity_Table_OperationType] FOREIGN KEY([OperationTypeID])
REFERENCES [dbo].[Table_OperationType] ([ID])
GO
ALTER TABLE [dbo].[Table_LogEntity] CHECK CONSTRAINT [FK_Table_LogEntity_Table_OperationType]
GO
ALTER TABLE [dbo].[Table_OperationLog]  WITH CHECK ADD  CONSTRAINT [FK_Table_OperationLog_Table_LogEntity] FOREIGN KEY([LogEntityID])
REFERENCES [dbo].[Table_LogEntity] ([ID])
GO
ALTER TABLE [dbo].[Table_OperationLog] CHECK CONSTRAINT [FK_Table_OperationLog_Table_LogEntity]
GO
ALTER TABLE [dbo].[Table_OperationLog]  WITH CHECK ADD  CONSTRAINT [FK_Table_OperationLog_Table_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Table_User] ([ID])
GO
ALTER TABLE [dbo].[Table_OperationLog] CHECK CONSTRAINT [FK_Table_OperationLog_Table_User]
GO
ALTER TABLE [dbo].[Table_Question]  WITH CHECK ADD  CONSTRAINT [FK_Table_Question_Table_BBSItem] FOREIGN KEY([TypeId])
REFERENCES [dbo].[Table_BBSItem] ([ID])
GO
ALTER TABLE [dbo].[Table_Question] CHECK CONSTRAINT [FK_Table_Question_Table_BBSItem]
GO
ALTER TABLE [dbo].[Table_Question]  WITH CHECK ADD  CONSTRAINT [FK_Table_Question_Table_User] FOREIGN KEY([Publisher])
REFERENCES [dbo].[Table_User] ([ID])
GO
ALTER TABLE [dbo].[Table_Question] CHECK CONSTRAINT [FK_Table_Question_Table_User]
GO
ALTER TABLE [dbo].[Table_SubBlogReply]  WITH CHECK ADD  CONSTRAINT [FK_Table_SubBlogReply_Table_BlogReply] FOREIGN KEY([ReplyID])
REFERENCES [dbo].[Table_BlogReply] ([ID])
GO
ALTER TABLE [dbo].[Table_SubBlogReply] CHECK CONSTRAINT [FK_Table_SubBlogReply_Table_BlogReply]
GO
ALTER TABLE [dbo].[Table_SubBlogReply]  WITH CHECK ADD  CONSTRAINT [FK_Table_SubBlogReply_Table_User] FOREIGN KEY([Publisher])
REFERENCES [dbo].[Table_User] ([ID])
GO
ALTER TABLE [dbo].[Table_SubBlogReply] CHECK CONSTRAINT [FK_Table_SubBlogReply_Table_User]
GO
USE [master]
GO
ALTER DATABASE [BYSDN] SET  READ_WRITE 
GO
