USE [demo]
GO
/****** Object:  Table [dbo].[BookDatebase]    Script Date: 2017/10/29 1:03:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookDatebase](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[BookName] [nchar](10) NOT NULL,
	[Author] [nchar](10) NOT NULL,
	[Class] [nchar](10) NOT NULL,
 CONSTRAINT [PK_BookDate] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BookEvent]    Script Date: 2017/10/29 1:03:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookEvent](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nchar](10) NOT NULL,
	[BookName] [nchar](10) NOT NULL,
	[BoodID] [int] NOT NULL,
 CONSTRAINT [PK_BookEvent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[users]    Script Date: 2017/10/29 1:03:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[username] [nchar](10) NOT NULL,
	[password] [nchar](10) NOT NULL,
 CONSTRAINT [PK_users_1] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[users] ([username], [password]) VALUES (N'123       ', N'123123    ')
ALTER TABLE [dbo].[BookEvent]  WITH CHECK ADD  CONSTRAINT [FK_BookEvent_BookDatebase] FOREIGN KEY([BoodID])
REFERENCES [dbo].[BookDatebase] ([id])
GO
ALTER TABLE [dbo].[BookEvent] CHECK CONSTRAINT [FK_BookEvent_BookDatebase]
GO
ALTER TABLE [dbo].[BookEvent]  WITH CHECK ADD  CONSTRAINT [FK_BookEvent_users] FOREIGN KEY([UserName])
REFERENCES [dbo].[users] ([username])
GO
ALTER TABLE [dbo].[BookEvent] CHECK CONSTRAINT [FK_BookEvent_users]
GO
