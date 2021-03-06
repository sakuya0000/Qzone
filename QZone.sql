/****** Object:  Database [QZone]    Script Date: 2017/12/10 23:42:50 ******/
CREATE DATABASE [QZone]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QZone', FILENAME = N'D:\software\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\QZone.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QZone_log', FILENAME = N'D:\software\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\QZone_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QZone] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QZone].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QZone] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QZone] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QZone] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QZone] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QZone] SET ARITHABORT OFF 
GO
ALTER DATABASE [QZone] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QZone] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [QZone] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QZone] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QZone] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QZone] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QZone] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QZone] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QZone] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QZone] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QZone] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QZone] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QZone] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QZone] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QZone] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QZone] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QZone] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QZone] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QZone] SET RECOVERY FULL 
GO
ALTER DATABASE [QZone] SET  MULTI_USER 
GO
ALTER DATABASE [QZone] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QZone] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QZone] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QZone] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QZone', N'ON'
GO
/****** Object:  Table [dbo].[Album]    Script Date: 2017/12/10 23:42:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Album](
	[PicID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](50) NOT NULL,
	[Path] [nvarchar](max) NOT NULL,
	[Time] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Album] PRIMARY KEY CLUSTERED 
(
	[PicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Album_FileList]    Script Date: 2017/12/10 23:42:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Album_FileList](
	[Album_FileListID] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [nvarchar](50) NOT NULL,
	[QQNum] [nvarchar](50) NOT NULL,
	[Time] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Album_FileList] PRIMARY KEY CLUSTERED 
(
	[Album_FileListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Journal]    Script Date: 2017/12/10 23:42:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Journal](
	[JournalID] [int] IDENTITY(1,1) NOT NULL,
	[QQNum] [nvarchar](50) NOT NULL,
	[Date] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Substance] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Journal] PRIMARY KEY CLUSTERED 
(
	[JournalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Journal_Com]    Script Date: 2017/12/10 23:42:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Journal_Com](
	[Journal_ComID] [int] IDENTITY(1,1) NOT NULL,
	[JournalID] [int] NOT NULL,
	[QQNum] [nvarchar](50) NOT NULL,
	[VisitorName] [nvarchar](50) NOT NULL,
	[Date] [nvarchar](50) NOT NULL,
	[Substance] [nvarchar](max) NOT NULL,
	[ResponseTo] [int] NULL,
 CONSTRAINT [PK_Journal_Com] PRIMARY KEY CLUSTERED 
(
	[Journal_ComID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Message_Board]    Script Date: 2017/12/10 23:42:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message_Board](
	[Message_BoradID] [int] IDENTITY(1,1) NOT NULL,
	[QQNum] [nvarchar](50) NOT NULL,
	[Substance] [nvarchar](max) NOT NULL,
	[Time] [nvarchar](50) NOT NULL,
	[Owner_QQNum] [nvarchar](50) NOT NULL,
	[ResponseToID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[New_Events]    Script Date: 2017/12/10 23:42:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[New_Events](
	[NewID] [int] IDENTITY(1,1) NOT NULL,
	[EventType] [int] NOT NULL,
	[EventID] [int] NOT NULL,
	[Substance] [nvarchar](max) NULL,
	[Time] [nvarchar](50) NOT NULL,
	[QQNum] [nvarchar](50) NOT NULL,
	[Image1] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QQFriends]    Script Date: 2017/12/10 23:42:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QQFriends](
	[QQNum] [nvarchar](50) NOT NULL,
	[FriendQQNum] [nvarchar](50) NOT NULL,
	[FriendUserName] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QQFriends_Request]    Script Date: 2017/12/10 23:42:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QQFriends_Request](
	[EventID] [int] IDENTITY(1,1) NOT NULL,
	[QQNum] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[RequestToQQNum] [nvarchar](50) NOT NULL,
	[RequestToUserName] [nvarchar](50) NOT NULL,
	[Time] [nvarchar](50) NOT NULL,
	[Status] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SaySay]    Script Date: 2017/12/10 23:42:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaySay](
	[SaySayID] [int] IDENTITY(1,1) NOT NULL,
	[QQNum] [nvarchar](50) NOT NULL,
	[OwnerName] [nvarchar](50) NOT NULL,
	[Substance] [nvarchar](max) NOT NULL,
	[Time] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SaySay] PRIMARY KEY CLUSTERED 
(
	[SaySayID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SaySay_Com]    Script Date: 2017/12/10 23:42:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SaySay_Com](
	[SaySay_ComID] [int] IDENTITY(1,1) NOT NULL,
	[QQNum] [nvarchar](50) NOT NULL,
	[VisitorName] [nvarchar](50) NOT NULL,
	[SaySayID] [int] NOT NULL,
	[Substance] [nvarchar](max) NOT NULL,
	[Time] [nvarchar](50) NOT NULL,
	[ResponseTo] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Test]    Script Date: 2017/12/10 23:42:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Test](
	[TestID] [int] IDENTITY(1,1) NOT NULL,
	[Substance] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 2017/12/10 23:42:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[QQNum] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Sex] [int] NOT NULL,
	[Age] [int] NOT NULL,
	[Birthday] [nvarchar](50) NOT NULL,
	[Constellation] [nvarchar](50) NOT NULL,
	[BloodType] [nvarchar](3) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[QQNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Album] ON 

INSERT [dbo].[Album] ([PicID], [FileName], [Path], [Time]) VALUES (27, N'天天&&&78469ad50a58a3fc/', N'/Zone/Album/天天&&&78469ad50a58a3fc/dd0ca34c25c105d9.jpg', N'2017/12/10 16:22:29')
SET IDENTITY_INSERT [dbo].[Album] OFF
SET IDENTITY_INSERT [dbo].[Album_FileList] ON 

INSERT [dbo].[Album_FileList] ([Album_FileListID], [FileName], [QQNum], [Time]) VALUES (11, N'天天&&&78469ad50a58a3fc/', N'533877538', N'2017/12/10 16:21:58')
INSERT [dbo].[Album_FileList] ([Album_FileListID], [FileName], [QQNum], [Time]) VALUES (12, N'方法&&&d8cabb06d01d6a74/', N'533877538', N'2017/12/10 21:27:59')
SET IDENTITY_INSERT [dbo].[Album_FileList] OFF
SET IDENTITY_INSERT [dbo].[Journal] ON 

INSERT [dbo].[Journal] ([JournalID], [QQNum], [Date], [Title], [Substance]) VALUES (2, N'169772236', N'2017-01-01', N'21', N'212')
INSERT [dbo].[Journal] ([JournalID], [QQNum], [Date], [Title], [Substance]) VALUES (3, N'169772236', N'2014-12-08', N'36', N'154')
INSERT [dbo].[Journal] ([JournalID], [QQNum], [Date], [Title], [Substance]) VALUES (4, N'169772236', N'2013-09-07', N'16', N'54')
INSERT [dbo].[Journal] ([JournalID], [QQNum], [Date], [Title], [Substance]) VALUES (5, N'169772236', N'2017-12-03', N'1', N'1')
INSERT [dbo].[Journal] ([JournalID], [QQNum], [Date], [Title], [Substance]) VALUES (6, N'169772236', N'2017-12-03', N'1', N'11')
INSERT [dbo].[Journal] ([JournalID], [QQNum], [Date], [Title], [Substance]) VALUES (7, N'169772236', N'2017-12-03', N'1', N'11')
INSERT [dbo].[Journal] ([JournalID], [QQNum], [Date], [Title], [Substance]) VALUES (8, N'169772236', N'2017-12-03', N'1', N'11')
INSERT [dbo].[Journal] ([JournalID], [QQNum], [Date], [Title], [Substance]) VALUES (16, N'533877538', N'2017/12/10 15:46:34', N'你好', N'你好')
INSERT [dbo].[Journal] ([JournalID], [QQNum], [Date], [Title], [Substance]) VALUES (17, N'490365613', N'2017/12/10 15:47:30', N'hhh', N'hhh')
INSERT [dbo].[Journal] ([JournalID], [QQNum], [Date], [Title], [Substance]) VALUES (18, N'387826823', N'2017/12/10 15:48:36', N'天哪', N'天哪')
INSERT [dbo].[Journal] ([JournalID], [QQNum], [Date], [Title], [Substance]) VALUES (19, N'213037199', N'2017/12/10 15:49:45', N'oo', N'oo')
INSERT [dbo].[Journal] ([JournalID], [QQNum], [Date], [Title], [Substance]) VALUES (26, N'533877538', N'2017/12/10 22:07:19', N'hhh', N'hhh')
SET IDENTITY_INSERT [dbo].[Journal] OFF
SET IDENTITY_INSERT [dbo].[Journal_Com] ON 

INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (9, 2, N'169772236', N'asdasdsd', N'2017-12-12', N'哈哈', NULL)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (10, 2, N'29896373344', N'asd', N'2017-11-11', N'谔谔', NULL)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (11, 2, N'63394627053', N'qwe', N'2017-12-10', N'月月', NULL)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (13, 2, N'169772236', N'asdasdsd', N'2017-12-12', N'方法', 9)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (15, 2, N'29896373344', N'asd', N'2017-12-30', N'辅导费', 10)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (16, 2, N'169772236', N'asdasdsd', N'2017/12/9 13:53:34', N'<p>123<br></p>', NULL)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (17, 2, N'169772236', N'asdasdsd', N'2017/12/9 14:46:43', N'<p><br><img style="max-width:100%;" src="https://b-ssl.duitang.com/uploads/item/201406/28/20140628084407_WkunE.jpeg"></p><p>hh</p>', NULL)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (18, 2, N'169772236', N'asdasdsd', N'2017/12/9 15:02:37', N'123', 9)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (19, 2, N'169772236', N'asdasdsd', N'2017/12/9 15:03:31', N'123', 9)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (20, 2, N'169772236', N'asdasdsd', N'2017/12/9 15:04:54', N'123', 11)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (21, 19, N'490365613', N'测试2号', N'2017/12/10 16:45:33', N'<p><br>123123123</p>', NULL)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (22, 19, N'490365613', N'测试2号', N'2017/12/10 16:45:36', N'123123', 21)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (23, 17, N'490365613', N'测试2号', N'2017/12/10 16:54:23', N'<p><br>asas</p>', NULL)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (24, 17, N'490365613', N'测试2号', N'2017/12/10 16:54:32', N'asd', 23)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (25, 16, N'490365613', N'测试2号', N'2017/12/10 16:56:21', N'<p>hhh<br></p>', NULL)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (26, 16, N'490365613', N'测试2号', N'2017/12/10 17:41:24', N'e', 25)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (27, 16, N'533877538', N'测试1号', N'2017/12/10 21:51:06', N'123', 25)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (28, 16, N'533877538', N'测试1号', N'2017/12/10 21:54:33', N'<p>123<br></p>', NULL)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (29, 16, N'533877538', N'测试1号', N'2017/12/10 21:54:38', N'<p>123<br></p>', NULL)
INSERT [dbo].[Journal_Com] ([Journal_ComID], [JournalID], [QQNum], [VisitorName], [Date], [Substance], [ResponseTo]) VALUES (30, 26, N'533877538', N'测试1号', N'2017/12/10 22:07:24', N'<p><br>123</p>', NULL)
SET IDENTITY_INSERT [dbo].[Journal_Com] OFF
SET IDENTITY_INSERT [dbo].[Message_Board] ON 

INSERT [dbo].[Message_Board] ([Message_BoradID], [QQNum], [Substance], [Time], [Owner_QQNum], [ResponseToID]) VALUES (1, N'169772236', N'你好', N'2017-02-02', N'29896373344', NULL)
INSERT [dbo].[Message_Board] ([Message_BoradID], [QQNum], [Substance], [Time], [Owner_QQNum], [ResponseToID]) VALUES (13, N'29896373344', N'<h1>123<br></h1>', N'2017/12/9 11:12:08', N'169772236', NULL)
INSERT [dbo].[Message_Board] ([Message_BoradID], [QQNum], [Substance], [Time], [Owner_QQNum], [ResponseToID]) VALUES (4, N'169772236', N'谢谢', N'2017-02-04', N'169772236', 1)
INSERT [dbo].[Message_Board] ([Message_BoradID], [QQNum], [Substance], [Time], [Owner_QQNum], [ResponseToID]) VALUES (6, N'63394627053 ', N'谢谢', N'2017-02-02', N'111', NULL)
INSERT [dbo].[Message_Board] ([Message_BoradID], [QQNum], [Substance], [Time], [Owner_QQNum], [ResponseToID]) VALUES (16, N'29896373344', N'123', N'2017/12/9 11:17:59', N'169772236', 15)
INSERT [dbo].[Message_Board] ([Message_BoradID], [QQNum], [Substance], [Time], [Owner_QQNum], [ResponseToID]) VALUES (14, N'29896373344', N'<p align="center"><br>123</p>', N'2017/12/9 11:12:43', N'169772236', NULL)
INSERT [dbo].[Message_Board] ([Message_BoradID], [QQNum], [Substance], [Time], [Owner_QQNum], [ResponseToID]) VALUES (15, N'29896373344', N'<p>123<br></p>', N'2017/12/9 11:15:18', N'169772236', NULL)
INSERT [dbo].[Message_Board] ([Message_BoradID], [QQNum], [Substance], [Time], [Owner_QQNum], [ResponseToID]) VALUES (17, N'29896373344', N'<h1>sadhfjksanfjlksnflksdnflksa</h1><div>sdfjhsjlkandflkf</div>sdafjknsd<p><br></p><p><br></p>', N'2017/12/9 11:23:56', N'169772236', NULL)
INSERT [dbo].[Message_Board] ([Message_BoradID], [QQNum], [Substance], [Time], [Owner_QQNum], [ResponseToID]) VALUES (18, N'533877538', N'<p>你好<br></p>', N'2017/12/10 16:54:41', N'490365613', NULL)
INSERT [dbo].[Message_Board] ([Message_BoradID], [QQNum], [Substance], [Time], [Owner_QQNum], [ResponseToID]) VALUES (19, N'533877538', N'hhh', N'2017/12/10 16:54:45', N'490365613', 18)
INSERT [dbo].[Message_Board] ([Message_BoradID], [QQNum], [Substance], [Time], [Owner_QQNum], [ResponseToID]) VALUES (20, N'533877538', N'<p><br></p>', N'2017/12/10 17:05:02', N'490365613', NULL)
SET IDENTITY_INSERT [dbo].[Message_Board] OFF
SET IDENTITY_INSERT [dbo].[New_Events] ON 

INSERT [dbo].[New_Events] ([NewID], [EventType], [EventID], [Substance], [Time], [QQNum], [Image1]) VALUES (19, 1, 17, N'hhh', N'2017/12/10 15:47:30', N'490365613', NULL)
INSERT [dbo].[New_Events] ([NewID], [EventType], [EventID], [Substance], [Time], [QQNum], [Image1]) VALUES (21, 2, 15, N'<p><br><img style="max-width:100%;" src="https://b-ssl.duitang.com/uploads/item/201506/19/20150619153936_x325J.png"></p>', N'2017/12/10 15:48:13', N'490365613', NULL)
INSERT [dbo].[New_Events] ([NewID], [EventType], [EventID], [Substance], [Time], [QQNum], [Image1]) VALUES (22, 1, 18, N'天哪', N'2017/12/10 15:48:36', N'387826823', NULL)
INSERT [dbo].[New_Events] ([NewID], [EventType], [EventID], [Substance], [Time], [QQNum], [Image1]) VALUES (16, 1, 16, N'你好', N'2017/12/10 15:46:34', N'533877538', NULL)
INSERT [dbo].[New_Events] ([NewID], [EventType], [EventID], [Substance], [Time], [QQNum], [Image1]) VALUES (17, 2, 14, N'<p><br><img style="max-width:100%;" src="https://b-ssl.duitang.com/uploads/item/201410/26/20141026165912_vCXJu.jpeg"></p>', N'2017/12/10 15:46:45', N'533877538', NULL)
INSERT [dbo].[New_Events] ([NewID], [EventType], [EventID], [Substance], [Time], [QQNum], [Image1]) VALUES (24, 2, 16, N'<p><br><img style="max-width:100%;" src="https://b-ssl.duitang.com/uploads/item/201311/18/20131118114555_ACr3r.thumb.700_0.jpeg"></p>', N'2017/12/10 15:49:19', N'387826823', NULL)
INSERT [dbo].[New_Events] ([NewID], [EventType], [EventID], [Substance], [Time], [QQNum], [Image1]) VALUES (25, 1, 19, N'oo', N'2017/12/10 15:49:45', N'213037199', NULL)
INSERT [dbo].[New_Events] ([NewID], [EventType], [EventID], [Substance], [Time], [QQNum], [Image1]) VALUES (27, 2, 17, N'<p><br><img style="max-width:100%;" src="https://b-ssl.duitang.com/uploads/item/201302/25/20130225174418_m2AhK.thumb.700_0.jpeg"></p>', N'2017/12/10 15:50:26', N'213037199', NULL)
INSERT [dbo].[New_Events] ([NewID], [EventType], [EventID], [Substance], [Time], [QQNum], [Image1]) VALUES (28, 3, 27, NULL, N'2017/12/10 16:22:29', N'533877538', N'/Zone/Album/天天&&&78469ad50a58a3fc/dd0ca34c25c105d9.jpg')
INSERT [dbo].[New_Events] ([NewID], [EventType], [EventID], [Substance], [Time], [QQNum], [Image1]) VALUES (29, 1, 26, N'hhh', N'2017/12/10 22:07:19', N'533877538', NULL)
SET IDENTITY_INSERT [dbo].[New_Events] OFF
INSERT [dbo].[QQFriends] ([QQNum], [FriendQQNum], [FriendUserName]) VALUES (N'490365613', N'533877538', N'测试1号')
INSERT [dbo].[QQFriends] ([QQNum], [FriendQQNum], [FriendUserName]) VALUES (N'533877538', N'490365613', N'测试2号')
INSERT [dbo].[QQFriends] ([QQNum], [FriendQQNum], [FriendUserName]) VALUES (N'387826823', N'490365613', N'测试2号')
INSERT [dbo].[QQFriends] ([QQNum], [FriendQQNum], [FriendUserName]) VALUES (N'490365613', N'387826823', N'测试3号')
INSERT [dbo].[QQFriends] ([QQNum], [FriendQQNum], [FriendUserName]) VALUES (N'387826823', N'533877538', N'测试1号')
INSERT [dbo].[QQFriends] ([QQNum], [FriendQQNum], [FriendUserName]) VALUES (N'533877538', N'387826823', N'测试3号')
INSERT [dbo].[QQFriends] ([QQNum], [FriendQQNum], [FriendUserName]) VALUES (N'213037199', N'387826823', N'测试3号')
INSERT [dbo].[QQFriends] ([QQNum], [FriendQQNum], [FriendUserName]) VALUES (N'387826823', N'213037199', N'测试4号')
INSERT [dbo].[QQFriends] ([QQNum], [FriendQQNum], [FriendUserName]) VALUES (N'213037199', N'490365613', N'测试2号')
INSERT [dbo].[QQFriends] ([QQNum], [FriendQQNum], [FriendUserName]) VALUES (N'490365613', N'213037199', N'测试4号')
INSERT [dbo].[QQFriends] ([QQNum], [FriendQQNum], [FriendUserName]) VALUES (N'213037199', N'533877538', N'测试1号')
INSERT [dbo].[QQFriends] ([QQNum], [FriendQQNum], [FriendUserName]) VALUES (N'533877538', N'213037199', N'测试4号')
SET IDENTITY_INSERT [dbo].[SaySay] ON 

INSERT [dbo].[SaySay] ([SaySayID], [QQNum], [OwnerName], [Substance], [Time]) VALUES (14, N'533877538', N'测试1号', N'<p><br><img style="max-width:100%;" src="https://b-ssl.duitang.com/uploads/item/201410/26/20141026165912_vCXJu.jpeg"></p>', N'2017/12/10 15:46:45')
INSERT [dbo].[SaySay] ([SaySayID], [QQNum], [OwnerName], [Substance], [Time]) VALUES (15, N'490365613', N'测试2号', N'<p><br><img style="max-width:100%;" src="https://b-ssl.duitang.com/uploads/item/201506/19/20150619153936_x325J.png"></p>', N'2017/12/10 15:48:13')
INSERT [dbo].[SaySay] ([SaySayID], [QQNum], [OwnerName], [Substance], [Time]) VALUES (16, N'387826823', N'测试3号', N'<p><br><img style="max-width:100%;" src="https://b-ssl.duitang.com/uploads/item/201311/18/20131118114555_ACr3r.thumb.700_0.jpeg"></p>', N'2017/12/10 15:49:19')
INSERT [dbo].[SaySay] ([SaySayID], [QQNum], [OwnerName], [Substance], [Time]) VALUES (17, N'213037199', N'测试4号', N'<p><br><img style="max-width:100%;" src="https://b-ssl.duitang.com/uploads/item/201302/25/20130225174418_m2AhK.thumb.700_0.jpeg"></p>', N'2017/12/10 15:50:26')
SET IDENTITY_INSERT [dbo].[SaySay] OFF
SET IDENTITY_INSERT [dbo].[SaySay_Com] ON 

INSERT [dbo].[SaySay_Com] ([SaySay_ComID], [QQNum], [VisitorName], [SaySayID], [Substance], [Time], [ResponseTo]) VALUES (9, N'490365613', N'测试2号', 17, N'hhh', N'2017/12/10 16:45:18', NULL)
INSERT [dbo].[SaySay_Com] ([SaySay_ComID], [QQNum], [VisitorName], [SaySayID], [Substance], [Time], [ResponseTo]) VALUES (10, N'490365613', N'测试2号', 17, N'hhh', N'2017/12/10 16:45:24', 9)
INSERT [dbo].[SaySay_Com] ([SaySay_ComID], [QQNum], [VisitorName], [SaySayID], [Substance], [Time], [ResponseTo]) VALUES (11, N'490365613', N'测试2号', 17, N'ee', N'2017/12/10 17:40:39', 9)
INSERT [dbo].[SaySay_Com] ([SaySay_ComID], [QQNum], [VisitorName], [SaySayID], [Substance], [Time], [ResponseTo]) VALUES (12, N'490365613', N'测试2号', 14, N'ee', N'2017/12/10 17:41:00', NULL)
INSERT [dbo].[SaySay_Com] ([SaySay_ComID], [QQNum], [VisitorName], [SaySayID], [Substance], [Time], [ResponseTo]) VALUES (13, N'490365613', N'测试2号', 14, N'oo', N'2017/12/10 17:41:03', 12)
INSERT [dbo].[SaySay_Com] ([SaySay_ComID], [QQNum], [VisitorName], [SaySayID], [Substance], [Time], [ResponseTo]) VALUES (14, N'490365613', N'测试2号', 14, N'1', N'2017/12/10 17:41:12', 12)
INSERT [dbo].[SaySay_Com] ([SaySay_ComID], [QQNum], [VisitorName], [SaySayID], [Substance], [Time], [ResponseTo]) VALUES (15, N'490365613', N'测试2号', 14, N'1', N'2017/12/10 17:41:15', NULL)
INSERT [dbo].[SaySay_Com] ([SaySay_ComID], [QQNum], [VisitorName], [SaySayID], [Substance], [Time], [ResponseTo]) VALUES (16, N'490365613', N'测试2号', 16, N'oo', N'2017/12/10 17:41:34', NULL)
INSERT [dbo].[SaySay_Com] ([SaySay_ComID], [QQNum], [VisitorName], [SaySayID], [Substance], [Time], [ResponseTo]) VALUES (17, N'490365613', N'测试2号', 16, N'1', N'2017/12/10 17:41:37', 16)
INSERT [dbo].[SaySay_Com] ([SaySay_ComID], [QQNum], [VisitorName], [SaySayID], [Substance], [Time], [ResponseTo]) VALUES (18, N'490365613', N'测试2号', 16, N'2', N'2017/12/10 17:41:42', NULL)
SET IDENTITY_INSERT [dbo].[SaySay_Com] OFF
INSERT [dbo].[Users] ([QQNum], [UserName], [Password], [Sex], [Age], [Birthday], [Constellation], [BloodType]) VALUES (N'152788528', N'测试5号', N'25f9e794323b453885f5181f1b624d0b', 1, 10, N'2007-01-01', N'摩羯座', N'其他')
INSERT [dbo].[Users] ([QQNum], [UserName], [Password], [Sex], [Age], [Birthday], [Constellation], [BloodType]) VALUES (N'169772236', N'asdasdsd', N'f5bb0c8de146c67b44babbf4e6584cc0', 1, 1, N'2016-05-31', N'双子座', N'B型')
INSERT [dbo].[Users] ([QQNum], [UserName], [Password], [Sex], [Age], [Birthday], [Constellation], [BloodType]) VALUES (N'213037199', N'测试4号', N'25f9e794323b453885f5181f1b624d0b', 1, 10, N'2007-01-01', N'摩羯座', N'其他')
INSERT [dbo].[Users] ([QQNum], [UserName], [Password], [Sex], [Age], [Birthday], [Constellation], [BloodType]) VALUES (N'29896373344', N'asd', N'f5bb0c8de146c67b44babbf4e6584cc0', 1, 10, N'2007-01-01', N'摩羯座', N'其他')
INSERT [dbo].[Users] ([QQNum], [UserName], [Password], [Sex], [Age], [Birthday], [Constellation], [BloodType]) VALUES (N'387826823', N'测试3号', N'25f9e794323b453885f5181f1b624d0b', 1, 10, N'2007-01-01', N'摩羯座', N'其他')
INSERT [dbo].[Users] ([QQNum], [UserName], [Password], [Sex], [Age], [Birthday], [Constellation], [BloodType]) VALUES (N'490365613', N'测试2号', N'25f9e794323b453885f5181f1b624d0b', 1, 10, N'2007-01-01', N'摩羯座', N'其他')
INSERT [dbo].[Users] ([QQNum], [UserName], [Password], [Sex], [Age], [Birthday], [Constellation], [BloodType]) VALUES (N'533877538', N'测试1号', N'25f9e794323b453885f5181f1b624d0b', 1, 10, N'2007-01-01', N'摩羯座', N'其他')
INSERT [dbo].[Users] ([QQNum], [UserName], [Password], [Sex], [Age], [Birthday], [Constellation], [BloodType]) VALUES (N'63394627053', N'qwe', N'f5bb0c8de146c67b44babbf4e6584cc0', 1, 10, N'2007-01-01', N'摩羯座', N'其他')
ALTER TABLE [dbo].[Journal]  WITH CHECK ADD  CONSTRAINT [FK_Journal_Users] FOREIGN KEY([QQNum])
REFERENCES [dbo].[Users] ([QQNum])
GO
ALTER TABLE [dbo].[Journal] CHECK CONSTRAINT [FK_Journal_Users]
GO
ALTER TABLE [dbo].[Journal_Com]  WITH CHECK ADD  CONSTRAINT [FK_Journal_Com_Journal] FOREIGN KEY([JournalID])
REFERENCES [dbo].[Journal] ([JournalID])
GO
ALTER TABLE [dbo].[Journal_Com] CHECK CONSTRAINT [FK_Journal_Com_Journal]
GO
ALTER DATABASE [QZone] SET  READ_WRITE 
GO
