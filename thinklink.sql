-- phpMyAdmin SQL Dump
-- version 2.9.1.1-Debian-2ubuntu1
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Aug 01, 2008 at 09:12 PM
-- Server version: 5.0.38
-- PHP Version: 5.2.1
-- 
-- Database: `thinklink`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `bookmarks`
-- 

CREATE TABLE `bookmarks` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL,
  `snippet_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`id`,`user_id`,`snippet_id`),
  UNIQUE KEY `user_id` (`user_id`,`snippet_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

-- 
-- Dumping data for table `bookmarks`
-- 

INSERT INTO `bookmarks` (`id`, `user_id`, `snippet_id`) VALUES 
(1, 8, 2),
(2, 1, 81),
(3, 8, 12),
(4, 8, 8),
(5, 8, 14),
(6, 1, 155),
(7, 1, 159),
(10, 1, 160),
(11, 1, 161),
(12, 1, 169),
(13, 1, 174),
(14, 1, 192),
(15, 1, 221),
(16, 1, 220);

-- --------------------------------------------------------

-- 
-- Table structure for table `deletions`
-- 

CREATE TABLE `deletions` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `user_id` int(11) unsigned NOT NULL,
  `snippet_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`id`,`user_id`,`snippet_id`),
  UNIQUE KEY `user_id` (`user_id`,`snippet_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- 
-- Dumping data for table `deletions`
-- 

INSERT INTO `deletions` (`id`, `user_id`, `snippet_id`) VALUES 
(1, 8, 1),
(2, 8, 2),
(3, 1, 158),
(4, 1, 157),
(5, 1, 156);

-- --------------------------------------------------------

-- 
-- Table structure for table `documents`
-- 

CREATE TABLE `documents` (
  `url` varchar(128) NOT NULL,
  `title` varchar(128) default NULL,
  `author` varchar(128) default NULL,
  PRIMARY KEY  (`url`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `documents`
-- 

INSERT INTO `documents` (`url`, `title`, `author`) VALUES 
('http://mashmaker.intel-research.net/rob/server/pdfs/d3/7/', 'Finding Contradictions in Text', 'Marie-Catherine de Marneffe'),
('http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', 'Ivan Titov, Ryan McDonald'),
('http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/', 'The information ecology of social media and online communities', 'Tim Finin, Anupam Joshi, Pranam Kolari, Akshay Java, Anubhav Kale and Amit Karandikar'),
('http://mashmaker.intel-research.net/rob/server/pdfs/f5/16/', 'Fully Distributed EM for Very Large Datasets', 'Jason Wolfe, Aria Haghighi, Dan Klein'),
('http://mashmaker.intel-research.net/rob/server/pdfs/da/18/', 'DISTRIBUTIONAL CLUSTERING OF ENGLISH WORDS', 'Fernando Pereira'),
('http://mashmaker.intel-research.net/rob/server/pdfs/ea/19/', 'Information Seeking: Sensemaking and Interactions', 'Ann Abraham, Marian Petre, Helen Sharp');

-- --------------------------------------------------------

-- 
-- Table structure for table `keywords`
-- 

CREATE TABLE `keywords` (
  `word` varchar(32) NOT NULL,
  `point` int(11) NOT NULL,
  PRIMARY KEY  (`word`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `keywords`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `link`
-- 

CREATE TABLE `link` (
  `source_id` int(11) NOT NULL,
  `howlinked` enum('asserts','supports','identical','opposes','related') NOT NULL,
  `creator` int(11) NOT NULL,
  `linktype` enum('pp','sp') NOT NULL,
  `destid` int(11) NOT NULL,
  KEY `relation` (`howlinked`),
  KEY `creator` (`creator`),
  KEY `id` (`source_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `link`
-- 

INSERT INTO `link` (`source_id`, `howlinked`, `creator`, `linktype`, `destid`) VALUES 
(7, 'opposes', 0, 'pp', 9),
(9, 'supports', 0, 'pp', 2),
(7, 'supports', 0, 'pp', 3),
(7, 'supports', 0, 'sp', 4),
(5, 'asserts', 0, 'sp', 11),
(6, 'supports', 0, 'sp', 3),
(8, 'opposes', 0, 'sp', 7),
(10, 'supports', 0, 'sp', 7),
(11, 'supports', 0, 'sp', 21),
(0, '', 0, 'pp', 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `pdf`
-- 

CREATE TABLE `pdf` (
  `url` varchar(512) NOT NULL,
  `dir` varchar(4) NOT NULL,
  `id` int(4) NOT NULL auto_increment,
  PRIMARY KEY  (`id`),
  KEY `url` (`url`,`dir`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

-- 
-- Dumping data for table `pdf`
-- 

INSERT INTO `pdf` (`url`, `dir`, `id`) VALUES 
('http://www.educationaldatamining.org/EDM2008/uploads/proc/14_Lynch_43.pdf', '60', 5),
('http://ebiquity.umbc.edu/_file_directory_/papers/376.pdf', '2d', 6),
('http://www.aclweb.org/anthology-new/P/P08/P08-1118.pdf', 'd3', 7),
('http://www.aclweb.org/anthology-new/P/P08/P08-1036.pdf', '3c', 8),
('http://fmdb.cs.ucla.edu/Treports/890045.pdf', '98', 9),
('http://ebiquity.umbc.edu/paper/html/id/371/', 'd3', 11),
('http://portal.acm.org/ft_gateway.cfm?id=169209&type=pdf&coll=portal&dl=ACM&CFID=78220272&CFTOKEN=68137937', '73', 13),
('http://www.cs.berkeley.edu/~klein/papers/similarity-search-WWW-11.pdf', '5a', 14),
('http://portal.acm.org/ft_gateway.cfm?id=317451&type=pdf&coll=GUIDE&dl=GUIDE&CFID=36969353&CFTOKEN=78065988', '14', 15),
('http://www.cs.berkeley.edu/~aria42/pubs/icml08-distributedem.pdf', 'f5', 16),
('http://www.cs.berkeley.edu/~pliang/papers/agreement-nips2008.pdf', 'eb', 17),
('http://www.cs.cornell.edu/home/llee/papers/ptl93.pdf', 'da', 18),
('http://dmrussell.googlepages.com/Abraham-final.pdf', 'ea', 19);

-- --------------------------------------------------------

-- 
-- Table structure for table `point_agreements`
-- 

CREATE TABLE `point_agreements` (
  `user_id` int(11) unsigned NOT NULL,
  `point_id` int(11) unsigned NOT NULL,
  `agree` tinyint(1) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY  (`user_id`,`point_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `point_agreements`
-- 

INSERT INTO `point_agreements` (`user_id`, `point_id`, `agree`, `created_at`) VALUES 
(8, 72, 1, '0000-00-00 00:00:00'),
(8, 2, 1, '0000-00-00 00:00:00');

-- --------------------------------------------------------

-- 
-- Table structure for table `point_deletions`
-- 

CREATE TABLE `point_deletions` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `point_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`,`user_id`,`point_id`),
  UNIQUE KEY `user_id` (`user_id`,`point_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `point_deletions`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `point_links`
-- 

CREATE TABLE `point_links` (
  `id` int(11) NOT NULL auto_increment,
  `point_a_id` int(11) unsigned NOT NULL,
  `point_b_id` int(11) unsigned NOT NULL,
  `howlinked` enum('same','supports','opposes','opposite','related') NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `onelink` (`point_a_id`,`point_b_id`),
  KEY `dest` (`point_b_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=72 ;

-- 
-- Dumping data for table `point_links`
-- 

INSERT INTO `point_links` (`id`, `point_a_id`, `point_b_id`, `howlinked`, `user_id`) VALUES 
(1, 1, 2, 'same', 8),
(2, 8, 10, 'related', 1),
(3, 7, 9, 'related', 1),
(4, 8, 12, 'related', 1),
(5, 12, 14, 'related', 1),
(6, 13, 16, 'related', 1),
(7, 8, 20, 'related', 1),
(8, 20, 25, 'related', 1),
(9, 23, 25, 'related', 1),
(10, 21, 26, 'related', 1),
(11, 12, 21, 'related', 1),
(12, 19, 27, 'related', 1),
(13, 27, 39, 'related', 8),
(14, 26, 39, 'related', 8),
(15, 21, 39, 'related', 8),
(16, 8, 40, 'related', 8),
(17, 14, 40, 'supports', 8),
(18, 33, 42, 'related', 8),
(19, 6, 33, 'related', 8),
(20, 33, 44, 'related', 8),
(21, 47, 48, 'related', 1),
(22, 48, 49, 'related', 1),
(23, 47, 49, 'related', 1),
(24, 67, 68, 'opposes', 8),
(25, 70, 71, 'related', 8),
(26, 67, 74, 'opposes', 8),
(27, 67, 75, 'related', 8),
(28, 74, 75, 'related', 8),
(29, 76, 77, 'supports', 8),
(30, 78, 79, 'related', 8),
(31, 81, 102, 'related', 1),
(32, 103, 104, 'related', 1),
(33, 103, 106, 'related', 1),
(34, 108, 109, 'related', 1),
(35, 108, 111, 'related', 1),
(36, 109, 111, 'related', 1),
(62, 3, 118, 'opposite', 8),
(61, 1, 118, 'same', 8),
(60, 2, 118, 'same', 8),
(42, 2, 3, 'opposite', 8),
(63, 138, 139, 'supports', 1),
(64, 133, 140, 'supports', 1),
(65, 133, 137, 'supports', 1),
(66, 145, 146, 'opposes', 1),
(67, 152, 153, 'supports', 1),
(68, 136, 161, 'supports', 1),
(69, 136, 163, 'supports', 1),
(70, 139, 167, 'supports', 1),
(71, 190, 191, 'supports', 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `point_topics`
-- 

CREATE TABLE `point_topics` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `point_id` int(11) unsigned NOT NULL,
  `topic_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `point_id` (`point_id`,`topic_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=38 ;

-- 
-- Dumping data for table `point_topics`
-- 

INSERT INTO `point_topics` (`id`, `point_id`, `topic_id`, `user_id`) VALUES 
(1, 2, 1, 8),
(2, 3, 1, 8),
(3, 72, 3, 8),
(4, 131, 5, 1),
(5, 128, 5, 1),
(6, 132, 5, 1),
(7, 133, 6, 1),
(8, 136, 6, 1),
(9, 135, 6, 1),
(10, 137, 6, 1),
(11, 143, 7, 1),
(12, 143, 6, 1),
(13, 147, 8, 1),
(14, 148, 9, 1),
(15, 150, 10, 1),
(16, 150, 9, 1),
(17, 148, 11, 1),
(18, 149, 11, 1),
(19, 151, 9, 1),
(20, 153, 12, 1),
(21, 152, 6, 1),
(22, 158, 13, 1),
(23, 159, 13, 1),
(24, 154, 14, 1),
(25, 160, 6, 1),
(26, 168, 6, 1),
(27, 168, 15, 1),
(28, 175, 6, 1),
(29, 176, 6, 1),
(30, 176, 16, 1),
(31, 175, 16, 1),
(32, 183, 17, 1),
(33, 183, 6, 1),
(34, 197, 18, 1),
(35, 197, 19, 1),
(36, 196, 19, 1),
(37, 201, 9, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `points`
-- 

CREATE TABLE `points` (
  `id` int(11) NOT NULL auto_increment,
  `txt` varchar(128) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `txt` (`txt`),
  FULLTEXT KEY `text` (`txt`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=203 ;

-- 
-- Dumping data for table `points`
-- 

INSERT INTO `points` (`id`, `txt`, `user_id`, `created_at`, `updated_at`) VALUES 
(1, 'test point 1', 0, '2008-07-14 11:03:32', '0000-00-00 00:00:00'),
(2, 'test point 2', 0, '2008-07-14 11:04:22', '0000-00-00 00:00:00'),
(3, 'Viewing opposing arguments helps people decide which argument they agree with', 0, '2008-07-14 11:15:25', '0000-00-00 00:00:00'),
(4, 'Scope and context are important for statements and arguments', 0, '2008-07-14 11:17:15', '0000-00-00 00:00:00'),
(5, 'Relationships between statements may be vague or difficult to define', 0, '2008-07-14 15:41:45', '0000-00-00 00:00:00'),
(6, 'NLP tasks require large training sets to be effective', 0, '2008-07-14 15:54:29', '0000-00-00 00:00:00'),
(7, 'Social media systems contribute up to one third of new web content.', 0, '2008-07-15 13:44:34', '0000-00-00 00:00:00'),
(8, 'Finin et al analysed blogs to detect spam blogs, influential blogs, opinions, and communities of interest.', 0, '2008-07-15 13:46:04', '0000-00-00 00:00:00'),
(9, 'Millions of people contribute to social media', 0, '2008-07-15 13:46:31', '0000-00-00 00:00:00'),
(10, 'Finin et al modeled information flow and trust on blogs', 0, '2008-07-15 13:48:31', '0000-00-00 00:00:00'),
(11, 'One can infer social networks from blog posts', 0, '2008-07-15 14:06:29', '0000-00-00 00:00:00'),
(12, 'Finin et al detected influential blogs', 0, '2008-07-15 14:07:23', '0000-00-00 00:00:00'),
(13, 'Influence on the web is often a function of topic', 0, '2008-07-15 14:08:52', '0000-00-00 00:00:00'),
(14, 'Epidemic models can be used to find influential individuals', 0, '2008-07-15 14:09:20', '0000-00-00 00:00:00'),
(15, 'A blog can be very influential without having many readers', 0, '2008-07-15 14:10:19', '0000-00-00 00:00:00'),
(16, 'One can infer blog topics by looking at Bloglines folders', 0, '2008-07-15 14:14:24', '0000-00-00 00:00:00'),
(17, 'Researchers have performed sentiment extraction on blog posts', 0, '2008-07-15 14:18:09', '0000-00-00 00:00:00'),
(18, 'We can predict "tipping points" by analysing sentiment in blogs', 0, '2008-07-15 14:18:43', '0000-00-00 00:00:00'),
(19, 'blog posts are difficult to analyse with standard language analysis tools', 0, '2008-07-15 14:19:32', '0000-00-00 00:00:00'),
(20, 'Finin et al showed how to eliminate spam content from blogs', 0, '2008-07-15 14:20:29', '0000-00-00 00:00:00'),
(21, '"link polarity" allows one to deduce which blogs influence each other', 0, '2008-07-15 14:22:09', '0000-00-00 00:00:00'),
(22, 'Spam is a serious problem for blogs and social media', 0, '2008-07-15 14:25:38', '0000-00-00 00:00:00'),
(23, 'Spam blogs use hijacked content to draw attention to adverts or link farms', 0, '2008-07-15 14:28:29', '0000-00-00 00:00:00'),
(24, 'Spam blogs can be detected by looking at the word sequences on the page', 0, '2008-07-15 14:30:26', '0000-00-00 00:00:00'),
(25, 'Spam blogs can be detected by looking at what links to them', 0, '2008-07-15 14:32:11', '0000-00-00 00:00:00'),
(26, 'One can infer link polarity by the words around the link', 0, '2008-07-15 14:34:17', '0000-00-00 00:00:00'),
(27, 'Link polarity can be inferred without using complex natural language processing techniques', 0, '2008-07-15 14:36:00', '0000-00-00 00:00:00'),
(28, 'Republican blogs typically have a higher connectivity than democrat blogs', 0, '2008-07-15 14:38:11', '0000-00-00 00:00:00'),
(29, 'Finin et al applied trust propagation models over polar links to infer trust and influence patterns for blogs', 0, '2008-07-15 14:39:23', '0000-00-00 00:00:00'),
(30, 'Blog writers are enthusiastic blog readers', 0, '2008-07-15 14:55:57', '0000-00-00 00:00:00'),
(31, 'Summary statements can serve as a representation of a document', 0, '2008-07-16 10:56:50', '0000-00-00 00:00:00'),
(32, 'Document similarity needs to consider both document content  and inlinks', 0, '2008-07-16 11:03:23', '0000-00-00 00:00:00'),
(33, 'Parallel execution may be necessary to process a large volume of data', 0, '2008-07-16 11:05:44', '0000-00-00 00:00:00'),
(34, 'User studies are ineffective', 0, '2008-07-16 11:07:16', '0000-00-00 00:00:00'),
(35, 'Hierarchical data organization on the web groups similar data together', 0, '2008-07-16 11:11:57', '0000-00-00 00:00:00'),
(36, 'Deriving the full set of meaningful words is important to computing similarity', 0, '2008-07-16 11:19:52', '0000-00-00 00:00:00'),
(37, 'One can influence others'' opinions via blogging', 0, '2008-07-16 14:51:23', '0000-00-00 00:00:00'),
(38, 'User consensus is authoritative in document classification', 0, '2008-07-16 14:57:55', '0000-00-00 00:00:00'),
(39, 'Like-minded blogs can discovered using link polarity and trust propagation', 0, '2008-07-16 15:04:00', '0000-00-00 00:00:00'),
(40, 'The Blogosphere can be analyzed to discover the most influential bloggers', 0, '2008-07-16 15:08:37', '0000-00-00 00:00:00'),
(41, 'Feature selection is important in machine learning algorithms', 0, '2008-07-16 15:17:20', '0000-00-00 00:00:00'),
(42, 'MapReduce cannot be used when a centralized reduce operation has high overhead', 0, '2008-07-16 17:00:15', '0000-00-00 00:00:00'),
(43, 'LDA is useful for finding statements about the same topic', 0, '2008-07-16 17:15:04', '0000-00-00 00:00:00'),
(44, 'Parallel execution is easier when each data item is independent', 0, '2008-07-16 17:17:02', '0000-00-00 00:00:00'),
(45, 'Using a master node to communicate in distributed settings can be inefficient', 0, '2008-07-16 17:29:03', '0000-00-00 00:00:00'),
(46, 'Jesse Jackson uses the n-word to refer to black people', 0, '2008-07-16 18:59:24', '0000-00-00 00:00:00'),
(47, 'Nixon used executive privilege to dodge prosecution during the watergate scandal', 0, '2008-07-16 19:00:18', '0000-00-00 00:00:00'),
(48, 'George W Bush used executive priveledge to dodge prosecution over the Valerie Plame scandal', 0, '2008-07-16 19:01:07', '0000-00-00 00:00:00'),
(49, 'Executive privilege is not intended to be used to protect the president from investigation', 0, '2008-07-16 19:03:22', '0000-00-00 00:00:00'),
(50, 'Most diets do not work well', 0, '2008-07-16 19:27:10', '0000-00-00 00:00:00'),
(51, 'Dieters lose most weight at the beginning of the diet', 0, '2008-07-16 19:28:11', '0000-00-00 00:00:00'),
(52, 'Dieters often regain lost weight as the diet continues', 0, '2008-07-16 19:28:43', '0000-00-00 00:00:00'),
(53, 'If Apple loses the Psystar case then other companies are likely to start selling Mac clones', 0, '2008-07-16 19:31:06', '0000-00-00 00:00:00'),
(54, 'Many computer companies would like to sell Mac clones', 0, '2008-07-16 19:32:04', '0000-00-00 00:00:00'),
(55, 'EPO is the hormone that regulates red blood cell production', 0, '2008-07-16 19:40:06', '0000-00-00 00:00:00'),
(56, 'In rails one can use the class_name option to belongs_to to use arbitrary names for foreign keys', 0, '2008-07-16 22:26:54', '0000-00-00 00:00:00'),
(57, 'Rails programmers should use eager loading to reduce the number of database queries made', 0, '2008-07-16 22:28:08', '0000-00-00 00:00:00'),
(58, 'database views can be used to adapt a legacy database to rails conventions', 0, '2008-07-16 22:29:24', '0000-00-00 00:00:00'),
(59, 'set_table_name allows one to override the rails default table name', 0, '2008-07-16 22:38:50', '0000-00-00 00:00:00'),
(60, 'set_primary_key allows one to override the rails default primary key name', 0, '2008-07-16 22:39:21', '0000-00-00 00:00:00'),
(61, 'Taxes are too high in California', 0, '2008-07-17 09:22:56', '0000-00-00 00:00:00'),
(62, 'Middle-income wage-earners can find themselves pushed into higher tax brackets', 0, '2008-07-17 09:26:31', '0000-00-00 00:00:00'),
(63, 'People are moving away from California', 0, '2008-07-17 09:28:21', '0000-00-00 00:00:00'),
(64, 'California is dependent on its wealthy wage-earners', 0, '2008-07-17 09:29:10', '0000-00-00 00:00:00'),
(65, 'Housing prices are falling', 0, '2008-07-17 09:30:12', '0000-00-00 00:00:00'),
(66, 'California is spending too much money', 0, '2008-07-17 09:31:11', '0000-00-00 00:00:00'),
(67, 'The iPhone is the most popular smart phone', 0, '2008-07-17 09:40:21', '0000-00-00 00:00:00'),
(68, 'BlackBerrys have hidden features', 0, '2008-07-17 09:46:49', '0000-00-00 00:00:00'),
(69, 'The New Yorker magazine is influential', 0, '2008-07-17 09:49:24', '0000-00-00 00:00:00'),
(70, 'Barack Obama artwork is popular', 0, '2008-07-17 09:50:11', '0000-00-00 00:00:00'),
(71, 'African Americans are associated with graffiti', 0, '2008-07-17 09:51:42', '0000-00-00 00:00:00'),
(72, 'McCain is less controversial than Obama', 0, '2008-07-17 10:11:23', '0000-00-00 00:00:00'),
(73, 'Obama has used cocaine', 0, '2008-07-17 10:29:57', '0000-00-00 00:00:00'),
(74, 'The iPhone is lacking features', 0, '2008-07-17 10:39:34', '0000-00-00 00:00:00'),
(75, 'The iPhone is too expensive', 0, '2008-07-17 10:40:21', '0000-00-00 00:00:00'),
(76, 'The Bush administration is too conservative', 0, '2008-07-17 10:49:23', '0000-00-00 00:00:00'),
(77, 'The Bush administration is trying to redefine contraception as abortion', 0, '2008-07-17 10:50:28', '0000-00-00 00:00:00'),
(78, 'Text classification is useful', 0, '2008-07-18 11:00:26', '0000-00-00 00:00:00'),
(79, 'Text classification often deals with sparse data sets', 0, '2008-07-18 11:05:47', '0000-00-00 00:00:00'),
(80, 'rails 2.0 requires you to declare a named route for each type in order to use the form_for method', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(81, 'Rails partials allow one to include one view inside another', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(82, 'A suicide barrier on the Golden Gate bridge could make it more vulnerable to wind damage', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(83, 'The Golden Gate Bridge is more vulnerable to wind than to earthquakes', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(84, 'A suicide barrier on the Golden Gate Bridge could be dangerous for cyclist if it catches their handlebars', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(85, 'Over a thousand people have committed suicide from the Golden Gate Bridge', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(86, 'Erecting a suicide barrier on a bridge does not just push suicides elsewhere', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(87, 'Suicide barriers on bridges work effectively', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(88, 'People have been calling for a suicide barrier on the Golden Gate Bridge for a long time', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(89, 'A suicide barrier would ruin the visual experience of travelling across the golden gate bridge', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(90, 'Suicide barriers can make buildings less attractive', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(91, 'Jumping from the Golden Gate bridge almost always results in death', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(92, 'Jumping from a bridge is an unpleasant way to die', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(93, 'People who die in the water get eaten by fish', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(94, 'Letting people commit suicide on bridges prevents them killing themselves in ways that might harm others', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(95, 'Most people prevented from jumping off the golden gate bridge do not go on to commit suicide', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(96, '$25 million was spent adding a moveable median to the Golden Gate bridge - which would have saved only one life since 1997', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(97, 'The Golden Gate Bridge is the worlds most popular suicide spot', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(98, 'Most people who commit suicide on the golden gate bridge are local residents', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(99, 'Most people who jump from the Golden Gate Bridge are men', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(100, 'The Golden Gate bridge is popular for suicides because it is so easy to kill yourself there', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(101, 'The original design for the golden gate bridge included a higher barrier that would have reduced suicides', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(102, 'You can pass arguments to Rails partials ', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(103, 'Obama plans to withdraw US forces from Iraq over a 16 month period', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(104, 'The Iraqi prime minister endorses Obama''s plans for a troop withdrawl', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(105, 'McCain attacks Obama based on his lack of military experience', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(106, 'McCain plans to withdraw US forces from Iraq', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(107, 'Apple predicts a drop in sales in the coming quarter', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(108, 'Investors are worried about the health of Steve Jobs', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(109, 'Steve Jobs had pancreatic cancel in 2004', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(110, 'The success of Apple depends on Steve Jobs being healthy enough to lead them', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(111, 'Steve Jobs is looking dangerously thin', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(112, 'Steve Jobs kept private about having cancer previously', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(113, 'Apple needs to articulate a succession plan for life after Steve Jobs', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(114, 'Jonathan Ive is being touted as the successor to Steve Jobs as Apple CEO', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(115, 'Jonathan Ive is unlikely to succeed Steve Jobs', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(116, 'Jonathan ive has purchased a mansion in the UK', 0, '0000-00-00 00:00:00', '2008-07-21 22:38:19'),
(117, 'Christian zionists want the jews to return to Israel in order to hasten the end of the world', 0, '0000-00-00 00:00:00', '2008-07-22 13:17:00'),
(118, 'test point 3', 0, '0000-00-00 00:00:00', '2008-07-23 11:02:31'),
(119, 'Hasbro has sued the creators of Scrabulous', 0, '0000-00-00 00:00:00', '2008-07-24 15:50:26'),
(120, 'Hasbro''s official scrabble is much less popular than Scrabulous', 0, '0000-00-00 00:00:00', '2008-07-24 15:52:38'),
(121, 'If git gives you a "cannot merge" error then this may mean you need to commit recent changes', 0, '0000-00-00 00:00:00', '2008-07-24 17:03:33'),
(122, 'If git gives you a ''cannot merge'' error then this may mean you need to commit recent changes', 0, '0000-00-00 00:00:00', '2008-07-24 17:03:58'),
(123, 'MySql allows one to run a script file using the \\. or source command.', 0, '0000-00-00 00:00:00', '2008-07-24 19:18:26'),
(124, 'Labout will lose the next general election', 0, '0000-00-00 00:00:00', '2008-07-24 19:24:17'),
(125, 'Glasgow East was one of labour''s safest seats', 0, '0000-00-00 00:00:00', '2008-07-24 19:24:52'),
(126, 'Every part of Britain has turned against labour', 0, '0000-00-00 00:00:00', '2008-07-24 19:26:57'),
(127, 'Labour lost the Glasgow East byelection', 0, '0000-00-00 00:00:00', '2008-07-24 19:27:38'),
(128, 'The 2008 LA earthquake was 5.4 magnitude.', 0, '0000-00-00 00:00:00', '2008-07-29 14:12:44'),
(129, 'The 2008 LA earthquake caused no major damage or injuries', 0, '0000-00-00 00:00:00', '2008-07-29 14:13:12'),
(130, 'Ehud Olmert will resign once his party chooses a new leader', 0, '0000-00-00 00:00:00', '2008-07-30 14:43:05'),
(131, 'Cell phones jammed during the 2008 LA earthquake', 0, '0000-00-00 00:00:00', '2008-07-31 12:26:50'),
(132, 'There were roughly 50 aftershocks from the 2008 LA earthquake', 0, '0000-00-00 00:00:00', '2008-07-31 12:53:57'),
(133, 'Obama is not a muslim', 0, '0000-00-00 00:00:00', '2008-08-01 18:03:58'),
(134, 'Obama was an Illinois state senator for several years', 0, '0000-00-00 00:00:00', '2008-08-01 18:05:05'),
(135, 'Obama was born in Hawaii', 0, '0000-00-00 00:00:00', '2008-08-01 18:06:21'),
(136, 'Obama''s father is black and his mother is white', 0, '0000-00-00 00:00:00', '2008-08-01 18:06:41'),
(137, 'Obama attended both Catholic and Muslim schools', 0, '0000-00-00 00:00:00', '2008-08-01 18:10:24'),
(138, 'Obama''s father left when he was two years old', 0, '0000-00-00 00:00:00', '2008-08-01 18:12:30'),
(139, 'Obama was not influenced much by his father', 0, '0000-00-00 00:00:00', '2008-08-01 18:13:32'),
(140, 'Obama did not attend a madrassa', 0, '0000-00-00 00:00:00', '2008-08-01 18:16:30'),
(141, 'The Republican''s hope to use racism to defeat Obama', 0, '0000-00-00 00:00:00', '2008-08-01 18:21:06'),
(142, 'McCain and Obama both support a cap and trade system to restrict carbon emmissions', 0, '0000-00-00 00:00:00', '2008-08-01 18:22:26'),
(143, 'McCain''s campaign adverts misrepresent Obama', 0, '0000-00-00 00:00:00', '2008-08-01 18:25:08'),
(144, 'Obama is associated with violent 1960s radicals', 0, '0000-00-00 00:00:00', '2008-08-01 18:30:31'),
(145, 'Obama is a friend of the 1960s radical William Ayers', 0, '0000-00-00 00:00:00', '2008-08-01 18:32:03'),
(146, 'Obama is not a close friend of William Ayers', 0, '0000-00-00 00:00:00', '2008-08-01 18:32:22'),
(147, 'Hilary Clinton interned at a radical San Francisco law firm while in law chool', 0, '0000-00-00 00:00:00', '2008-08-01 18:33:25'),
(148, 'Bernadine Dohrn was leader of the Weather Underground', 0, '0000-00-00 00:00:00', '2008-08-01 18:41:19'),
(149, 'Bernadine Dohrn is a professor at Northwestern University', 0, '0000-00-00 00:00:00', '2008-08-01 18:42:02'),
(150, 'Bill Ayers was a central figure in the Weather Underground', 0, '0000-00-00 00:00:00', '2008-08-01 18:42:54'),
(151, 'The former members of the Weather Underground now live fairly normal lives', 0, '0000-00-00 00:00:00', '2008-08-01 18:46:08'),
(152, 'Obama lied about his uncle liberating Auschwitz', 0, '0000-00-00 00:00:00', '2008-08-01 18:59:27'),
(153, 'The only force to liberate Nazi death-camp victims were the soviets', 0, '0000-00-00 00:00:00', '2008-08-01 19:01:41'),
(154, 'Obama represented slum landlorn Tony Rezko', 0, '0000-00-00 00:00:00', '2008-08-01 19:06:53'),
(155, 'Obama received financial support from Tony Rezko', 0, '0000-00-00 00:00:00', '2008-08-01 19:07:48'),
(156, 'Obama''s senate district included several of Tony Rezko''s properties', 0, '0000-00-00 00:00:00', '2008-08-01 19:08:37'),
(157, 'Slum landlord Tony Rezko was part of Obama''s 2003 senate campaign finance committee', 0, '0000-00-00 00:00:00', '2008-08-01 19:09:40'),
(158, 'Tony Rezko was indicted for soliciting kickbacks', 0, '0000-00-00 00:00:00', '2008-08-01 19:12:48'),
(159, 'Obama turned down a job from Tony Rezko', 0, '0000-00-00 00:00:00', '2008-08-01 19:19:34'),
(160, 'Barack Obama is the first black nominee for a major US political party', 0, '0000-00-00 00:00:00', '2008-08-01 19:21:14'),
(161, 'Obama''s father is from Kenya', 0, '0000-00-00 00:00:00', '2008-08-01 19:23:54'),
(162, 'Obama''s father was an atheist', 0, '0000-00-00 00:00:00', '2008-08-01 19:24:49'),
(163, 'Obama''s mother is from Kansas', 0, '0000-00-00 00:00:00', '2008-08-01 19:25:08'),
(164, 'Obama''s father did a PhD at Harvard', 0, '0000-00-00 00:00:00', '2008-08-01 19:26:28'),
(165, 'Obama went to school in indonesia', 0, '0000-00-00 00:00:00', '2008-08-01 19:27:09'),
(166, 'Obama was known as "Barry" is a child', 0, '0000-00-00 00:00:00', '2008-08-01 19:27:49'),
(167, 'Obama only saw his father once after his parents divorced', 0, '0000-00-00 00:00:00', '2008-08-01 19:28:40'),
(168, 'Obama studied political science at Columbia University', 0, '0000-00-00 00:00:00', '2008-08-01 19:29:42'),
(169, 'Obama worked as a community organizer for low income residents in Chicago''s South Side', 0, '0000-00-00 00:00:00', '2008-08-01 19:30:59'),
(170, 'Obama was the first black editor of the Harvard Law Review', 0, '0000-00-00 00:00:00', '2008-08-01 19:31:41'),
(171, 'Obama taught at the University of Chicago law school', 0, '0000-00-00 00:00:00', '2008-08-01 19:32:10'),
(172, 'Obama published an autobiography in 1995 : Dreams from My Father', 0, '0000-00-00 00:00:00', '2008-08-01 19:32:51'),
(173, 'Obama represented the Chicago South Side neighborhood of Hyde Park in the Illinois State Senate', 0, '0000-00-00 00:00:00', '2008-08-01 19:33:39'),
(174, 'Obama made an unsuccessful run for the US House of representatives in 2000', 0, '0000-00-00 00:00:00', '2008-08-01 19:34:24'),
(175, 'Obama was an early opponent of the Iraq war', 0, '0000-00-00 00:00:00', '2008-08-01 19:34:49'),
(176, 'Obama predicted problems with the invasion of Iraq ', 0, '0000-00-00 00:00:00', '2008-08-01 19:35:46'),
(177, 'Obama was elected to the US senate in 2004', 0, '0000-00-00 00:00:00', '2008-08-01 19:37:17'),
(178, 'Obama gave the keynote speech at the 2004 Democratic National Convention', 0, '0000-00-00 00:00:00', '2008-08-01 19:38:02'),
(179, 'Obama won his senate seat with the largest electoral margin in Illinois history', 0, '0000-00-00 00:00:00', '2008-08-01 19:40:11'),
(180, 'Obama is only the third black elected to the US since reconstruction', 0, '0000-00-00 00:00:00', '2008-08-01 19:40:36'),
(181, 'Obama has worked together with republicans', 0, '0000-00-00 00:00:00', '2008-08-01 19:42:41'),
(182, 'Obama was the first person to raise the risk of Avian Flu on the senate floor', 0, '0000-00-00 00:00:00', '2008-08-01 19:43:14'),
(183, 'Obama lives in Chicago''s South Side', 0, '0000-00-00 00:00:00', '2008-08-01 19:44:09'),
(184, 'Obama does put his hand over his heart during the US national anthem', 0, '0000-00-00 00:00:00', '2008-08-01 19:47:17'),
(185, 'Barack Obama has no problem with the US pledge of allegiance', 0, '0000-00-00 00:00:00', '2008-08-01 19:48:02'),
(186, 'Obama was not sworn into office on the Quran', 0, '0000-00-00 00:00:00', '2008-08-01 19:49:02'),
(187, 'There are false rumurs circulating about Barack Obama''s patriotism', 0, '0000-00-00 00:00:00', '2008-08-01 19:50:18'),
(188, 'Obama would back limited off-shore drilling for oil', 0, '0000-00-00 00:00:00', '2008-08-01 19:51:25'),
(189, 'Obama is sceptical of the value of expanded off-shore drilling for oil', 0, '0000-00-00 00:00:00', '2008-08-01 19:52:14'),
(190, 'Obama changed his opinion on off-shore drilling for oil', 0, '0000-00-00 00:00:00', '2008-08-01 19:52:31'),
(191, 'Obama is a flip-flopper', 0, '0000-00-00 00:00:00', '2008-08-01 19:52:51'),
(192, 'Many bridges in America are structurally deficient', 0, '0000-00-00 00:00:00', '2008-08-01 19:55:28'),
(193, 'Higher US gas prices are causing reduced gas tax revenues', 0, '0000-00-00 00:00:00', '2008-08-01 19:56:31'),
(194, 'Nearly every US state is facing a budget crisis', 0, '0000-00-00 00:00:00', '2008-08-01 19:56:54'),
(195, 'Bridges in Minneapolis are still unsafe', 0, '0000-00-00 00:00:00', '2008-08-01 19:58:03'),
(196, 'Mars contains vast quantities of water ice', 0, '0000-00-00 00:00:00', '2008-08-01 20:02:00'),
(197, 'Mars contains water ice', 0, '0000-00-00 00:00:00', '2008-08-01 20:02:25'),
(198, 'The Weather Underground was originally known as The Weathermen', 0, '0000-00-00 00:00:00', '2008-08-01 20:06:16'),
(199, 'The Weather Underground organized riots and bombings', 0, '0000-00-00 00:00:00', '2008-08-01 20:06:46'),
(200, 'The Weather Underground sought to bring about world communism', 0, '0000-00-00 00:00:00', '2008-08-01 20:07:59'),
(201, 'The Weather Underground bombed symbols of capitalism and state authority', 0, '0000-00-00 00:00:00', '2008-08-01 20:08:55'),
(202, 'The Weather Underground were careful to not harm people with their bombings', 0, '0000-00-00 00:00:00', '2008-08-01 20:10:27');

-- --------------------------------------------------------

-- 
-- Table structure for table `ratings`
-- 

CREATE TABLE `ratings` (
  `snippet_id` int(11) unsigned NOT NULL,
  `point_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  `rating` int(4) unsigned NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY  (`snippet_id`,`point_id`,`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `ratings`
-- 

INSERT INTO `ratings` (`snippet_id`, `point_id`, `user_id`, `rating`, `created_at`) VALUES 
(1, 1, 8, 3, '2008-07-14 11:05:29'),
(46, 29, 1, 4, '2008-07-15 14:39:28'),
(45, 28, 1, 3, '2008-07-15 14:39:32'),
(28, 11, 8, 5, '2008-07-16 14:45:38'),
(30, 13, 8, 5, '2008-07-16 14:52:47'),
(36, 19, 8, 4, '2008-07-16 15:00:18');

-- --------------------------------------------------------

-- 
-- Table structure for table `snippet_links`
-- 

CREATE TABLE `snippet_links` (
  `snippet_id` int(11) unsigned NOT NULL,
  `point_id` int(11) unsigned NOT NULL,
  `howlinked` enum('asserts','supports','opposes') NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  KEY `point` (`point_id`),
  KEY `snippet` (`snippet_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `snippet_links`
-- 

INSERT INTO `snippet_links` (`snippet_id`, `point_id`, `howlinked`, `user_id`) VALUES 
(1, 1, 'asserts', 8),
(2, 2, 'asserts', 8),
(3, 3, 'supports', 8),
(4, 4, 'supports', 8),
(5, 5, 'supports', 8),
(6, 4, 'supports', 8),
(7, 6, 'supports', 8),
(8, 1, 'asserts', 8),
(9, 1, 'asserts', 8),
(10, 1, 'asserts', 8),
(11, 1, 'asserts', 8),
(12, 2, 'asserts', 8),
(13, 4, 'supports', 8),
(14, 2, 'asserts', 1),
(15, 1, 'asserts', 1),
(16, 2, 'asserts', 1),
(17, 2, 'asserts', 1),
(18, 1, 'asserts', 1),
(19, 1, 'asserts', 1),
(20, 2, 'asserts', 1),
(21, 1, 'asserts', 1),
(22, 1, 'asserts', 8),
(23, 7, 'asserts', 1),
(24, 8, 'asserts', 1),
(25, 9, 'asserts', 1),
(26, 7, 'asserts', 1),
(27, 10, 'asserts', 1),
(28, 11, 'asserts', 1),
(29, 12, 'asserts', 1),
(30, 13, 'asserts', 1),
(31, 14, 'asserts', 1),
(32, 15, 'asserts', 1),
(33, 16, 'asserts', 1),
(34, 17, 'asserts', 1),
(35, 18, 'asserts', 1),
(36, 19, 'asserts', 1),
(37, 20, 'asserts', 1),
(38, 21, 'asserts', 1),
(39, 22, 'asserts', 1),
(40, 23, 'asserts', 1),
(41, 24, 'supports', 1),
(42, 25, 'asserts', 1),
(43, 26, 'asserts', 1),
(44, 27, 'asserts', 1),
(45, 28, 'asserts', 1),
(46, 29, 'asserts', 1),
(47, 30, 'asserts', 1),
(48, 22, 'asserts', 1),
(49, 31, 'supports', 8),
(50, 32, 'asserts', 8),
(51, 33, 'supports', 8),
(52, 34, 'asserts', 8),
(53, 35, 'supports', 8),
(54, 36, 'asserts', 8),
(55, 36, 'asserts', 8),
(56, 11, 'asserts', 8),
(57, 37, 'supports', 8),
(58, 38, 'asserts', 8),
(59, 39, 'asserts', 8),
(60, 40, 'asserts', 8),
(61, 41, 'supports', 8),
(62, 33, 'asserts', 8),
(63, 42, 'supports', 8),
(64, 43, 'asserts', 8),
(65, 33, 'supports', 8),
(66, 44, 'asserts', 8),
(67, 45, 'asserts', 8),
(68, 46, 'asserts', 1),
(69, 47, 'asserts', 1),
(70, 48, 'asserts', 1),
(71, 49, 'asserts', 1),
(72, 50, 'asserts', 1),
(73, 51, 'asserts', 1),
(74, 52, 'asserts', 1),
(75, 53, 'asserts', 1),
(76, 54, 'asserts', 1),
(77, 55, 'asserts', 1),
(78, 56, 'asserts', 1),
(79, 57, 'asserts', 1),
(80, 58, 'asserts', 1),
(81, 59, 'asserts', 1),
(82, 60, 'asserts', 1),
(83, 61, 'supports', 8),
(84, 62, 'asserts', 8),
(85, 63, 'asserts', 8),
(86, 64, 'supports', 8),
(87, 65, 'supports', 8),
(88, 66, 'supports', 8),
(89, 67, 'supports', 8),
(90, 68, 'asserts', 8),
(91, 69, 'supports', 8),
(92, 70, 'supports', 8),
(93, 71, 'supports', 8),
(94, 72, 'supports', 8),
(95, 73, 'asserts', 8),
(96, 74, 'supports', 8),
(97, 75, 'asserts', 8),
(98, 74, 'supports', 8),
(99, 74, 'supports', 8),
(100, 74, 'supports', 8),
(101, 76, 'supports', 8),
(102, 77, 'asserts', 8),
(103, 76, 'supports', 8),
(104, 78, 'supports', 8),
(105, 79, 'asserts', 8),
(106, 2, 'asserts', 1),
(107, 80, 'asserts', 1),
(108, 1, 'asserts', 8),
(109, 1, 'asserts', 8),
(110, 81, 'asserts', 1),
(111, 82, 'asserts', 1),
(112, 83, 'asserts', 1),
(113, 84, 'asserts', 1),
(114, 85, 'asserts', 1),
(115, 86, 'asserts', 1),
(116, 87, 'asserts', 1),
(117, 88, 'asserts', 1),
(118, 89, 'asserts', 1),
(119, 90, 'asserts', 1),
(120, 91, 'asserts', 1),
(121, 92, 'asserts', 1),
(122, 93, 'asserts', 1),
(123, 94, 'asserts', 1),
(124, 85, 'asserts', 1),
(125, 95, 'asserts', 1),
(126, 96, 'asserts', 1),
(127, 97, 'asserts', 1),
(128, 98, 'asserts', 1),
(129, 99, 'asserts', 1),
(130, 95, 'asserts', 1),
(131, 100, 'asserts', 1),
(132, 101, 'asserts', 1),
(133, 102, 'asserts', 1),
(134, 103, 'asserts', 1),
(135, 104, 'asserts', 1),
(136, 105, 'asserts', 1),
(137, 106, 'asserts', 1),
(138, 107, 'asserts', 1),
(139, 108, 'asserts', 1),
(140, 109, 'asserts', 1),
(141, 110, 'asserts', 1),
(142, 111, 'asserts', 1),
(143, 112, 'asserts', 1),
(144, 113, 'asserts', 1),
(145, 114, 'asserts', 1),
(146, 111, 'asserts', 1),
(147, 115, 'asserts', 1),
(148, 116, 'asserts', 1),
(149, 117, 'asserts', 1),
(150, 117, 'asserts', 1),
(151, 2, 'supports', 8),
(152, 118, 'supports', 8),
(153, 119, 'supports', 1),
(154, 120, 'supports', 1),
(155, 121, 'supports', 1),
(156, 121, 'supports', 1),
(157, 122, 'supports', 1),
(158, 122, 'supports', 1),
(159, 123, 'supports', 1),
(160, 124, 'supports', 1),
(161, 125, 'supports', 1),
(162, 126, 'supports', 1),
(163, 127, 'supports', 1),
(164, 128, 'supports', 1),
(165, 129, 'supports', 1),
(166, 130, 'supports', 1),
(167, 130, 'supports', 1),
(168, 128, 'supports', 1),
(169, 131, 'supports', 1),
(170, 132, 'supports', 1),
(171, 2, 'supports', 8),
(172, 133, 'supports', 1),
(173, 134, 'supports', 1),
(174, 135, 'supports', 1),
(175, 136, 'supports', 1),
(176, 137, 'supports', 1),
(177, 138, 'supports', 1),
(178, 140, 'supports', 1),
(179, 141, 'supports', 1),
(180, 142, 'supports', 1),
(181, 143, 'supports', 1),
(182, 143, 'supports', 1),
(183, 144, 'supports', 1),
(184, 145, 'supports', 1),
(185, 146, 'supports', 1),
(186, 147, 'supports', 1),
(187, 148, 'supports', 1),
(188, 149, 'supports', 1),
(189, 150, 'supports', 1),
(190, 151, 'supports', 1),
(191, 152, 'supports', 1),
(192, 153, 'supports', 1),
(193, 154, 'supports', 1),
(194, 155, 'supports', 1),
(195, 156, 'supports', 1),
(196, 155, 'supports', 1),
(197, 157, 'supports', 1),
(198, 158, 'supports', 1),
(199, 159, 'supports', 1),
(200, 160, 'supports', 1),
(201, 135, 'supports', 1),
(202, 161, 'supports', 1),
(203, 162, 'supports', 1),
(204, 163, 'supports', 1),
(205, 138, 'supports', 1),
(206, 164, 'supports', 1),
(207, 165, 'supports', 1),
(208, 166, 'supports', 1),
(209, 167, 'supports', 1),
(210, 73, 'supports', 1),
(211, 168, 'supports', 1),
(212, 169, 'supports', 1),
(213, 170, 'supports', 1),
(214, 171, 'supports', 1),
(215, 172, 'supports', 1),
(216, 173, 'supports', 1),
(217, 174, 'supports', 1),
(218, 175, 'supports', 1),
(219, 176, 'supports', 1),
(220, 177, 'supports', 1),
(221, 178, 'supports', 1),
(222, 179, 'supports', 1),
(223, 180, 'supports', 1),
(224, 181, 'supports', 1),
(225, 182, 'supports', 1),
(226, 183, 'supports', 1),
(227, 184, 'supports', 1),
(228, 185, 'supports', 1),
(229, 185, 'supports', 1),
(230, 133, 'supports', 1),
(231, 186, 'supports', 1),
(232, 187, 'supports', 1),
(233, 188, 'supports', 1),
(234, 189, 'supports', 1),
(235, 190, 'supports', 1),
(236, 192, 'supports', 1),
(237, 193, 'supports', 1),
(238, 194, 'supports', 1),
(239, 195, 'supports', 1),
(240, 196, 'supports', 1),
(241, 197, 'supports', 1),
(242, 198, 'supports', 1),
(243, 199, 'supports', 1),
(244, 200, 'supports', 1),
(245, 201, 'supports', 1),
(246, 202, 'supports', 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `snippets`
-- 

CREATE TABLE `snippets` (
  `id` int(11) NOT NULL auto_increment,
  `txt` text NOT NULL,
  `url` varchar(128) NOT NULL,
  `pagetitle` varchar(128) NOT NULL,
  `title` varchar(128) NOT NULL,
  `author` varchar(128) default NULL,
  `source_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `point_id` int(11) unsigned NOT NULL,
  `howlinked` varchar(11) NOT NULL default 'related',
  PRIMARY KEY  (`id`),
  KEY `url` (`url`,`created_at`,`user_id`),
  KEY `point_id` (`point_id`),
  FULLTEXT KEY `text` (`txt`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=247 ;

-- 
-- Dumping data for table `snippets`
-- 

INSERT INTO `snippets` (`id`, `txt`, `url`, `pagetitle`, `title`, `author`, `source_id`, `created_at`, `user_id`, `point_id`, `howlinked`) VALUES 
(1, 'In the beginning God created the heaven and the earth. ', 'http://mashmaker.intel-research.net/beth/', 'testing', '', NULL, 0, '2008-07-14 11:03:32', 8, 1, 'related'),
(2, 'And the evening and the morning were the third day', 'http://mashmaker.intel-research.net/beth/', 'testing', '', NULL, 0, '2008-07-14 11:04:22', 8, 2, 'related'),
(3, 'the system could enable voters to make more informed choices between candidates and sift through the amount of available informa- tion', 'http://mashmaker.intel-research.net/rob/server/pdfs/d3/7/pdf-1.html', 'Page 1', 'Finding Contradictions in Text', NULL, 0, '2008-07-14 11:15:25', 8, 3, 'related'),
(4, 'The importance of event coreference was recognized in the MUC information extraction tasks in which it was key to identify sce- narios related to the same event', 'http://mashmaker.intel-research.net/rob/server/pdfs/d3/7/pdf-2.html', 'Page 2', 'Finding Contradictions in Text', NULL, 0, '2008-07-14 11:17:15', 8, 4, 'related'),
(5, 'However, for contradiction detection to be useful, a looser definition that more closely matches human intuitions is necessary', 'http://mashmaker.intel-research.net/rob/server/pdfs/d3/7/pdf-2.html', 'Page 2', 'Finding Contradictions in Text', NULL, 0, '2008-07-14 15:42:46', 8, 5, 'related'),
(6, 'For contradiction, however, it is critical to filter unrelated sentences to avoid finding false evidence of contradiction when there is contrasting information about different events.', 'http://mashmaker.intel-research.net/rob/server/pdfs/d3/7/pdf-5.html', 'Page 5', 'Finding Contradictions in Text', NULL, 0, '2008-07-14 15:51:28', 8, 4, 'related'),
(7, 'highlight- ing the difficulty in generalizing from a small corpus of positive contradiction examples, as well as under- lining the complexity of building a broad coverage system', 'http://mashmaker.intel-research.net/rob/server/pdfs/d3/7/pdf-7.html', 'Page 7', 'Finding Contradictions in Text', NULL, 0, '2008-07-14 15:57:37', 8, 6, 'related'),
(8, 'And God made two great lights', 'http://mashmaker.intel-research.net/beth/', 'testing', '', '', 0, '2008-07-14 18:00:40', 8, 1, 'related'),
(9, 'And God set them in the firmament of the heaven to give light upon the earth, 18: And to rule over the day and over ', 'http://mashmaker.intel-research.net/beth/', 'testing', '', '', 0, '2008-07-14 18:04:15', 8, 1, 'related'),
(10, 'Online reviews ', 'http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/pdf-1.html', 'Page 1', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', '', 0, '2008-07-14 18:07:01', 8, 1, 'related'),
(11, 'We propose a statistical model which is able to discover corresponding topics in text and extract tex- tual evidence from reviews', 'http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/pdf-1.html', 'Page 1', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', '', 0, '2008-07-15 09:03:12', 8, 1, 'related'),
(12, 'Our model achieves high ac- curacy, without any explicitly labeled data ex- cept the user provided opinion ratings', 'http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/pdf-1.html', 'Page 1', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', 'Ivan Titov', 0, '2008-07-15 09:05:28', 8, 2, 'related'),
(13, 'A word in the document is sampled either from the mixture of global topics or from the mixture of local topics specific to the local context of the word.', 'http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/pdf-3.html', 'Page 3', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', 'Ivan Titov', 0, '2008-07-15 09:56:28', 8, 4, 'related'),
(14, 'in online discussion forum', 'http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/pdf-1.html', 'Page 1', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', NULL, 0, '2008-07-15 10:32:10', 1, 2, 'related'),
(15, 'However, these labels ', 'http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/pdf-1.html', 'Page 1', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', NULL, 0, '2008-07-15 10:32:41', 1, 1, 'related'),
(16, 'his study, we look at the', 'http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/pdf-1.html', 'Page 1', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', NULL, 0, '2008-07-15 10:33:15', 1, 2, 'related'),
(17, 'The first is aspect', 'http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/pdf-1.html', 'Page 1', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', NULL, 0, '2008-07-15 10:34:37', 1, 2, 'related'),
(18, 'For example', 'http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/pdf-1.html', 'Page 1', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', '', 0, '2008-07-15 10:37:01', 1, 1, 'related'),
(19, 'For example', 'http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/pdf-1.html', 'Page 1', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', '', 0, '2008-07-15 10:37:04', 1, 1, 'related'),
(20, 'coarse-grained', 'http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/pdf-1.html', 'Page 1', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', '', 0, '2008-07-15 10:37:25', 1, 2, 'related'),
(21, '2006', 'http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/pdf-1.html', 'Page 1', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', '', 0, '2008-07-15 10:49:38', 1, 1, 'related'),
(22, 'Though it may be reasonable to expect a user to provide a rating for each aspect, it is unlikely that a user will annotate every sentence and phrase in a review as being relevant to some aspect.', 'http://mashmaker.intel-research.net/rob/server/pdfs/3c/8/pdf-2.html', 'Page 2', 'A Joint Model of Text and Aspect Ratings for Sentiment Summarization', NULL, 0, '2008-07-15 13:17:23', 8, 1, 'related'),
(23, 'Social media systems such as weblogs, photo- and link- sharing sites, wikis and on-line forums are currently thought to produce up to one third of new Web content', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-1.html', 'Page 1', 'The information ecology of social media and online communities', '', 0, '2008-07-15 13:44:34', 1, 7, 'related'),
(24, 'We describe recent work on building systems that use models of the Blogosphere to recognize spam blogs, find opinions on topics, identify communities of interest, derive trust relationships, and detect influential bloggers.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-1.html', 'Page 1', 'The information ecology of social media and online communities', '', 0, '2008-07-15 13:46:04', 1, 8, 'related'),
(25, 'Their reach and impact is significant, with tens of mil- lions of people providing content on a regular basis around the world.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-1.html', 'Page 1', 'The information ecology of social media and online communities', '', 0, '2008-07-15 13:46:31', 1, 9, 'related'),
(26, 'Recent estimates suggest that so- cial media systems are responsible for as much as one third of new Web content', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-1.html', 'Page 1', 'The information ecology of social media and online communities', '', 0, '2008-07-15 13:46:50', 1, 7, 'related'),
(27, 'We are developing a model of information flow, in- fluence and trust on the Blogosphere', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-1.html', 'Page 1', 'The information ecology of social media and online communities', '', 0, '2008-07-15 13:48:31', 1, 10, 'related'),
(28, 'For example, the people who contribute to blogs and author blog posts form a so- cial network with their peers, which can be induced by the links between blogs.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-1.html', 'Page 1', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:06:29', 1, 11, 'related'),
(29, 'We begin by describing an overarching task of discovering which blogs and blog- gers are most influential within a community or about a topic.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-2.html', 'Page 2', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:07:23', 1, 12, 'related'),
(30, 'However, influ- ence on the Web is often a function of topic. For exam- ple, Engadget''s1 influence is in the domain of consumer electronics and Daily Kos2 in politics.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-2.html', 'Page 2', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:08:52', 1, 13, 'related'),
(31, 'Epidemic-based mod- els like linear threshold and cascade models (Kempe, Kleinberg, & Tardos 2003; 2005; Leskovec et al. 2007) have been used to find a small set of individuals who are most influential in social network.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-2.html', 'Page 2', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:09:20', 1, 14, 'related'),
(32, 'With the large number of niches existing on the Blogosphere, a blog that is relatively low ranked can be highly influential in this small community of interest', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-2.html', 'Page 2', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:10:19', 1, 15, 'related'),
(33, 'By clustering related folders, we can induce an intuitive set of topics for feeds and blogs.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-2.html', 'Page 2', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:14:24', 1, 16, 'related'),
(34, 'An important component in understanding influence is to detect the sentiment and opinions expressed in blog posts.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-2.html', 'Page 2', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:18:10', 1, 17, 'related'),
(35, 'An aggregated opinion over many users is a predictor for an interesting trend in a community. Sufficient adoption of this trend could lead to a "tip- ping point', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-2.html', 'Page 2', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:18:43', 1, 18, 'related'),
(36, 'Since blog posts are often informally written, poorly structured, rife with spelling and grammatical errors, and feature non-traditional content they are difficult to process with standard language analysis tools.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-3.html', 'Page 3', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:19:32', 1, 19, 'related'),
(37, 'In the next section we describe techniques designed to eliminate spam content from a blog index.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-3.html', 'Page 3', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:20:29', 1, 20, 'related'),
(38, 'In the following sections we also introduce a tech- nique we call "link polarity". We represent each edge in the influence graph with a vector of topic and corre- sponding weights indicating either positive or negative sentiment associated with the link for a Web resource. Thus if a blog A links to a blog B with a negative senti- ment for a topic T, influencing B would have little effect on A. ', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-3.html', 'Page 3', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:22:10', 1, 21, 'related'),
(39, 'spam has be- come a serious problem in blogs and social media', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-3.html', 'Page 3', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:25:38', 1, 22, 'related'),
(40, 'Spam blogs constitute the second kind of spam. These are blogs created using splog creation tools (Finin 2006), and are either fully or partly machine generated. Splogs have two often overlapping mo- tives. The first is the creation of blogs containing gib- berish or hijacked content from other blogs and news sources with the sole purpose of hosting profitable context based advertisements. The second is the cre- ation of blogs which realize link farms intended to increase the ranking of affiliate sites (blogs or non- blog web-pages). One such splog is shown in figure 4.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-4.html', 'Page 4', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:28:29', 1, 23, 'related'),
(41, 'For instance, text like "comments-off" (comments are usu- ally turned-off in splogs), "new-york" (a high paying advertising term), "in-uncategorized" (spammers do not bother to specify categories for blog posts) are features common to splogs, whereas text like "2-comments", "1- comment", "i-have", "to-my" were some features com- mon to authentic blogs.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-5.html', 'Page 5', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:30:26', 1, 24, 'related'),
(42, 'We have investigated the use of link distributions to see if splogs can be identified once they place themselves on the blog (web) hyper-link graph. The intuition is that that authentic blogs are very un- likely to link to splogs and that splogs frequently do link to other splogs.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-5.html', 'Page 5', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:32:11', 1, 25, 'related'),
(43, 'The text neighboring the link provides direct meaningful insight into blogger a''s opinion', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-5.html', 'Page 5', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:34:17', 1, 26, 'related'),
(44, 'For our requirements, we do not need to employ complex natural language processing techniques since bloggers typically convey their bias about the post/blog pointed by the link in a straightforward manner.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-6.html', 'Page 6', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:36:00', 1, 27, 'related'),
(45, 'Republican blogs typically have a higher connectivity then Democratic blogs in the politi- cal blogosphere', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-7.html', 'Page 7', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:38:11', 1, 28, 'related'),
(46, 'The main contribution of this work lies in applying trust propa- gation models over polar links.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-7.html', 'Page 7', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:39:23', 1, 29, 'related'),
(47, 'Blog writers are enthusiastic blog readers.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-7.html', 'Page 7', 'The information ecology of social media and online communities', NULL, 0, '2008-07-15 14:55:57', 1, 30, 'related'),
(48, 'Videotape of a Canadian teenager being questioned at the U.S. Navy base in Guantanamo Bay', 'http://www.bloomberg.com/apps/news?pid=20601086&sid=avX5fkXEfVWc', 'Bloomberg.com: Latin America', '', NULL, 0, '2008-07-15 18:30:35', 1, 22, 'related'),
(49, 'There are many possible ways to represent a document for the purpose of supporting effective similarity search.', 'http://www2002.org/CDROM/refereed/75/', 'Evaluating Strategies for Similarity Search on the Web', '', NULL, 0, '2008-07-16 10:56:50', 8, 31, 'related'),
(50, 'The anchor-window often constitutes a hand-built summary of the target document [1], collecting both explicit hand-summarization and implicit hand-classification present in referring documents.', 'http://www2002.org/CDROM/refereed/75/', 'Evaluating Strategies for Similarity Search on the Web', '', NULL, 0, '2008-07-16 11:03:23', 8, 32, 'related'),
(51, 'Because each stage of our algorithm is trivially parallelizable, our indexing approach can scale to the few billion accessible documents currently on the Web.', 'http://www2002.org/CDROM/refereed/75/', 'Evaluating Strategies for Similarity Search on the Web', '', NULL, 0, '2008-07-16 11:05:44', 8, 33, 'related'),
(52, 'user studies are time-consuming, costly, and not well-suited to research that involves the comparison of many parameters', 'http://www2002.org/CDROM/refereed/75/', 'Evaluating Strategies for Similarity Search on the Web', '', NULL, 0, '2008-07-16 11:07:16', 8, 34, 'related'),
(53, 'a document in the recreation/aviation/un-powered class is on average more similar to other documents in that same class than those outside of that class', 'http://www2002.org/CDROM/refereed/75/', 'Evaluating Strategies for Similarity Search on the Web', '', NULL, 0, '2008-07-16 11:11:57', 8, 35, 'related'),
(54, 'For both the content and anchor-based approaches, we chose to remove all HTML comments, Javascript code, tags (except ''alt'' text), and non-alphabetic characters. A stopword list containing roughly 800 terms was also applied.', 'http://www2002.org/CDROM/refereed/75/', 'Evaluating Strategies for Similarity Search on the Web', '', NULL, 0, '2008-07-16 11:19:52', 8, 36, 'related'),
(55, 'In the case where we are judging document similarities, rare terms are much less useful as they are often typos, rare names, or other nontopical terms that adversely affect the similarity measure.', 'http://www2002.org/CDROM/refereed/75/', 'Evaluating Strategies for Similarity Search on the Web', '', NULL, 0, '2008-07-16 11:35:07', 8, 36, 'related'),
(56, 'A typ- ical blog post has a set of comments that link back to people and blogs associated with them.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-2.html', 'Page 2', 'The information ecology of social media and online communities', NULL, 0, '2008-07-16 14:47:02', 8, 11, 'related'),
(57, 'Through original content and sometimes via commentary on top- ics of current interest, bloggers influence each other and their audience.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-2.html', 'Page 2', 'The information ecology of social media and online communities', NULL, 0, '2008-07-16 14:51:23', 8, 37, 'related'),
(58, 'In our approach, we say that a feed is topically relevant and authoritative if many users have cate- gorized it under similar folder names.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-2.html', 'Page 2', 'The information ecology of social media and online communities', NULL, 0, '2008-07-16 14:57:55', 8, 38, 'related'),
(59, 'Us- ing link polarity and trust propagation we have demon- strated how like-minded blogs can be discovered', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-3.html', 'Page 3', 'The information ecology of social media and online communities', NULL, 0, '2008-07-16 15:04:00', 8, 39, 'related'),
(60, 'By considering influence as a temporal phenomenon, we can find key individuals that are early adopters or "buzz generators" for a topic. ', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-3.html', 'Page 3', 'The information ecology of social media and online communities', NULL, 0, '2008-07-16 15:08:37', 8, 40, 'related'),
(61, 'Interesting discrim- inative features were observed in this experiment. For instance, text like "comments-off" (comments are usu- ally turned-off in splogs), "new-york" (a high paying advertising term), "in-uncategorized" (spammers do not bother to specify categories for blog posts) are features common to splogs, whereas text like "2-comments", "1- comment", "i-have", "to-my" were some features com- mon to authentic blogs.', 'http://mashmaker.intel-research.net/rob/server/pdfs/2d/6/pdf-5.html', 'Page 5', 'The information ecology of social media and online communities', NULL, 0, '2008-07-16 15:17:20', 8, 41, 'related'),
(65, 'Given the amount of data and number of parameters in many EM applications, it is worthwhile to distribute the algorithm across many machines.', 'http://mashmaker.intel-research.net/rob/server/pdfs/f5/16/pdf-3.html', 'Page 3', 'Fully Distributed EM for Very Large Datasets', NULL, 0, '2008-07-16 17:15:48', 8, 33, 'related'),
(64, 'In LDA, we fix a finite number of topics T and assume a closed vocabulary of size V .', 'http://mashmaker.intel-research.net/rob/server/pdfs/f5/16/pdf-2.html', 'Page 2', 'Fully Distributed EM for Very Large Datasets', NULL, 0, '2008-07-16 17:15:04', 8, 43, 'related'),
(63, 'In this case, one quickly gets to the point where no single compute node can store the model pa- rameters (expectations over word pairs in this case) for all of the data at once', 'http://mashmaker.intel-research.net/rob/server/pdfs/f5/16/pdf-1.html', 'Page 1', 'Fully Distributed EM for Very Large Datasets', NULL, 0, '2008-07-16 17:00:15', 8, 42, 'related'),
(62, 'With dramatic recent increases in both data scale and multi-core environments, it has become increasingly important to understand how machine learning algo- rithms can be efficiently parallelized.', 'http://mashmaker.intel-research.net/rob/server/pdfs/f5/16/pdf-1.html', 'Page 1', 'Fully Distributed EM for Very Large Datasets', NULL, 0, '2008-07-16 16:46:14', 8, 33, 'related'),
(66, 'Distributing the E-Step is relatively straightforward, since the expected sufficient statistics for each datum can be computed independently given a current esti- mate of the parameters.', 'http://mashmaker.intel-research.net/rob/server/pdfs/f5/16/pdf-3.html', 'Page 3', 'Fully Distributed EM for Very Large Datasets', NULL, 0, '2008-07-16 17:17:02', 8, 44, 'related'),
(67, 'MapReduce takes a completely centralized approach to implementing the C-Step, in which the accumula- tion of at the Reduce node can be slow or even infea- sible.', 'http://mashmaker.intel-research.net/rob/server/pdfs/f5/16/pdf-4.html', 'Page 4', 'Fully Distributed EM for Very Large Datasets', NULL, 0, '2008-07-16 17:29:03', 8, 45, 'related'),
(68, 'Jackson used the plural form of the â€œn-word,â€ not â€œblack people,â€ in the second part of his comment.', 'http://latimesblogs.latimes.com/washington/2008/07/what-else-jesse.html', 'What else Jesse Jackson said when he slammed Barack Obama | Top of the Ticket | Los Angeles Times', '', NULL, 0, '2008-07-16 18:59:24', 1, 46, 'related'),
(69, 'The concept of executive privilege rings a special bell with readers of a certain age. It was relied on by the Richard M. Nixon White House seeking to shield documents and personnel from inquiring congressional committees and prosecutors during the Watergate investigations.', 'http://latimesblogs.latimes.com/presidentbush/2008/07/cheney-plame-ag.html', 'Bush claims executive privilege in Valerie Plame Wilson case | Countdown to Crawford | Los Angeles Times', '', NULL, 0, '2008-07-16 19:00:18', 1, 47, 'related'),
(70, 'President Bush quietly claimed executive privilege on Tuesday, after Atty. Gen. Michael B. Mukasey requested the shield. Mukasey is seeking to avoid delivering to congressional investigators documents dealing with interviews of Vice President Dick Cheney and members of his staff regarding the unmasking of CIA covert agent Valerie Plame Wilson. ', 'http://latimesblogs.latimes.com/presidentbush/2008/07/cheney-plame-ag.html', 'Bush claims executive privilege in Valerie Plame Wilson case | Countdown to Crawford | Los Angeles Times', '', NULL, 0, '2008-07-16 19:01:07', 1, 48, 'related'),
(71, 'This executive privilege claim, and your justification for it, appears to turn the privilege on its head. The purpose of executive privilege is to encourage candid advice to the president, not to cover up what the vice president and White House staff say to investigating authorities when that information is requested in the course of congressional oversight.', 'http://latimesblogs.latimes.com/presidentbush/2008/07/cheney-plame-ag.html', 'Bush claims executive privilege in Valerie Plame Wilson case | Countdown to Crawford | Los Angeles Times', '', NULL, 0, '2008-07-16 19:03:22', 1, 49, 'related'),
(72, 'Instead, the results highlight the difficulty of weight loss and the fact that most diets do not work well.', 'http://www.nytimes.com/2008/07/17/health/nutrition/17diets.html', 'Long-Term Diet Study Suggests Success Is Hard to Come By - NYTimes.com', '', NULL, 0, '2008-07-16 19:27:14', 1, 50, 'related'),
(73, 'The biggest weight loss happened in the first five months of the diet â€” low-fat and Mediterranean dieters lost about 10 pounds, and low-carbohydrate dieters lost 14 pounds. ', 'http://www.nytimes.com/2008/07/17/health/nutrition/17diets.html', 'Long-Term Diet Study Suggests Success Is Hard to Come By - NYTimes.com', '', NULL, 0, '2008-07-16 19:28:11', 1, 51, 'related'),
(74, 'By the end of two years, all the dieters had regained some, but not all, of the lost weight.', 'http://www.nytimes.com/2008/07/17/health/nutrition/17diets.html', 'Long-Term Diet Study Suggests Success Is Hard to Come By - NYTimes.com', '', NULL, 0, '2008-07-16 19:28:43', 1, 52, 'related'),
(75, 'In one fell swoop, other companies will realize that they will be able to get away with selling Mac OS X on their own brand of computers and use the precedent of the Psystar case to their advantage if and when they face legal action from Apple.', 'http://news.cnet.com/8301-13506_3-9992544-17.html', 'Apple must win its case against Psystar -- or else | The Digital Home - Don Reisinger''s take on the tech closest to home - CNET ', '', NULL, 0, '2008-07-16 19:31:06', 1, 53, 'related'),
(76, 'I would venture to say that the vast majority of small computer companies are looking to jump on that bandwagon at any second and have waited this long because of their desire to see what happens to Psystar.', 'http://news.cnet.com/8301-13506_3-9992544-17.html', 'Apple must win its case against Psystar -- or else | The Digital Home - Don Reisinger''s take on the tech closest to home - CNET ', '', NULL, 0, '2008-07-16 19:32:04', 1, 54, 'related'),
(77, 'is the hormone that regulates red blood cell production', 'http://en.wikipedia.org/wiki/Erythropoietin', 'Erythropoietin - Wikipedia, the free encyclopedia', '', NULL, 0, '2008-07-16 19:40:06', 1, 55, 'related'),
(78, ':class_name - Specify the class name of the association. Use it only if that name canâ€˜t be inferred from the association name. So has_one :author will by default be linked to the Author class, but if the real class name is Person, youâ€˜ll have to specify it with this option.', 'http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#M000530', 'Module: ActiveRecord::Associations::ClassMethods', '', NULL, 0, '2008-07-16 22:26:54', 1, 56, 'related'),
(79, 'Through the use of eager loading, the 101 queries can be reduced to 2. ', 'http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html#M000530', 'Module: ActiveRecord::Associations::ClassMethods', '', NULL, 0, '2008-07-16 22:28:08', 1, 57, 'related'),
(80, 'if your database supports views then you can alias your table names and column names to Rails conventions.', 'http://wiki.rubyonrails.org/rails/pages/HowToUseLegacySchemas', 'HowToUseLegacySchemas in Ruby on Rails', '', NULL, 0, '2008-07-16 22:29:24', 1, 58, 'related'),
(81, 'For example, letâ€™s suppose that your legacy database use a table named FooBar, and that youâ€™d like to map the model Client onto this table. By using the set_table_name class method you can define this:', 'http://sl33p3r.free.fr/tutorials/rails/legacy/legacy_databases.html', 'Rails and Legacy Databases', '', NULL, 0, '2008-07-16 22:38:50', 1, 59, 'related'),
(82, 'The same goes for the private key. In RoR, the convention says that the primary key should be named id and should be auto-incremented. In many legacy databases the primary key wonâ€™t be named id. By using the set_primary_key you can redefine the name if the primary key to be used:', 'http://sl33p3r.free.fr/tutorials/rails/legacy/legacy_databases.html', 'Rails and Legacy Databases', '', NULL, 0, '2008-07-16 22:39:21', 1, 60, 'related'),
(83, 'New York City has long been the highest tax jurisdiction in the United States, but California politicians are proposing to steal that brass tiara.', 'http://online.wsj.com/article/SB121625150189660215.html', 'California as No. 1 - WSJ.com', '', NULL, 0, '2008-07-17 09:22:56', 8, 61, 'related'),
(84, 'This plan would also repeal indexing for inflation, which is a sneaky way for politicians to push middle-income Californians into higher tax brackets every year, especially when prices are rising as they are now.', 'http://online.wsj.com/article/SB121625150189660215.html', 'California as No. 1 - WSJ.com', '', NULL, 0, '2008-07-17 09:26:31', 8, 62, 'related'),
(85, 'Census Bureau data show that, from 1996-2005, 1.3 million more Americans left than came to California.', 'http://online.wsj.com/article/SB121625150189660215.html', 'California as No. 1 - WSJ.com', '', NULL, 0, '2008-07-17 09:28:21', 8, 63, 'related'),
(86, 'Those with incomes of more than $100,000 pay 83% of the state''s income taxes, and the richest 6,000 of the 38 million Californians pay $9 billion in taxes.', 'http://online.wsj.com/article/SB121625150189660215.html', 'California as No. 1 - WSJ.com', '', NULL, 0, '2008-07-17 09:29:10', 8, 64, 'related'),
(87, 'New housing data reveals that the average California home price fell by 28% from June 2007 to June 2008, almost double the decline of any other state.', 'http://online.wsj.com/article/SB121625150189660215.html', 'California as No. 1 - WSJ.com', '', NULL, 0, '2008-07-17 09:30:12', 8, 65, 'related'),
(88, 'State outlays were up 44% over the past five years, meaning that California is spending at a faster pace than even Congress. ', 'http://online.wsj.com/article/SB121625150189660215.html', 'California as No. 1 - WSJ.com', '', NULL, 0, '2008-07-17 09:31:11', 8, 66, 'related'),
(89, 'If you''re a BlackBerry user, you''re probably getting tired of hearing about all the things Apple''s iPhone can do.', 'http://online.wsj.com/article/SB121615180290355595.html', 'The Mossberg Solution - WSJ.com', '', NULL, 0, '2008-07-17 09:40:21', 8, 67, 'related'),
(90, 'This week, I gathered up some useful shortcuts that come built into most of the BlackBerrys, even older models, made by Research In Motion Ltd. but not many owners actually use or know about them.', 'http://online.wsj.com/article/SB121615180290355595.html', 'The Mossberg Solution - WSJ.com', '', NULL, 0, '2008-07-17 09:46:49', 8, 68, 'related'),
(91, 'This week''s New Yorker magazine cover, an illustration depicting Sen. Barack Obama and his wife as fist-bumping terrorists, has been all over the news.', 'http://online.wsj.com/article/SB121625710569060513.html', 'Picturing Obama - WSJ.com', '', NULL, 0, '2008-07-17 09:49:24', 8, 69, 'related'),
(92, 'Collectors, investors and fund-raisers -- many of them looking to cash in on the candidate''s popularity and place in history -- are snapping up campaign posters and other works depicting the presumptive Democratic nominee.', 'http://online.wsj.com/article/SB121625710569060513.html', 'Picturing Obama - WSJ.com', '', NULL, 0, '2008-07-17 09:50:11', 8, 70, 'related'),
(93, 'Much of the Obama art market is centered on "street art," a graffiti-inspired genre that takes the form of posters, stickers and other works that are meant to be plastered in public spaces.', 'http://online.wsj.com/article/SB121625710569060513.html', 'Picturing Obama - WSJ.com', '', NULL, 0, '2008-07-17 09:51:42', 8, 71, 'related'),
(94, 'There appears to be little demand for art promoting Sen. John McCain, the presumptive Republican presidential nominee, art experts say.', 'http://online.wsj.com/article/SB121625710569060513.html', 'Picturing Obama - WSJ.com', '', NULL, 0, '2008-07-17 10:11:23', 8, 72, 'related'),
(95, 'In Texas, Austin-based designer Baxter Orr, an Independent, created "Dope," a parody of Mr. Fairey''s posters that makes sport of Mr. Obama''s cocaine use as a young man.', 'http://online.wsj.com/article/SB121625710569060513.html', 'Picturing Obama - WSJ.com', '', NULL, 0, '2008-07-17 10:29:57', 8, 73, 'related'),
(96, 'Seven Reasons Why the New iPhone Sucks', 'http://www.divinecaroline.com/article/22279/52271-seven-reasons-new-iphone-sucks', 'Seven Reasons Why the New iPhone Sucks', '', NULL, 0, '2008-07-17 10:39:34', 8, 74, 'related'),
(97, 'If you take into account the regular monthly fee, the data fee, the text message fee, which used to be free, and the $99 annual mobileme fee you could end up spending over $1,000 a year to own an iPhone', 'http://www.divinecaroline.com/article/22279/52271-seven-reasons-new-iphone-sucks', 'Seven Reasons Why the New iPhone Sucks', '', NULL, 0, '2008-07-17 10:40:21', 8, 75, 'related'),
(98, 'Although there are plenty of phones, including AT&Tâ€™s Tilt, that will allow you to use your 3G phone as a high speed modem for your laptop, the iPhone wonâ€™t be one of them', 'http://www.divinecaroline.com/article/22279/52271-seven-reasons-new-iphone-sucks', 'Seven Reasons Why the New iPhone Sucks', '', NULL, 0, '2008-07-17 10:42:41', 8, 74, 'related'),
(99, 'Yes it will superimpose your position on a Google map, or show you the closest pizzeria but what about getting real-time route guidance?', 'http://www.divinecaroline.com/article/22279/52271-seven-reasons-new-iphone-sucks', 'Seven Reasons Why the New iPhone Sucks', '', NULL, 0, '2008-07-17 10:43:09', 8, 74, 'related'),
(100, 'Predictive typing is fine but spell checkers are everywhere else but here. ', 'http://www.divinecaroline.com/article/22279/52271-seven-reasons-new-iphone-sucks', 'Seven Reasons Why the New iPhone Sucks', '', NULL, 0, '2008-07-17 10:43:36', 8, 74, 'related'),
(101, 'While current law allows health care providers and professionals to refuse to provide abortions based on their religious beliefs, this provision would threaten the funding of organizations and health facilities if they do not hire people who would refuse to provide birth control and defines abortion so broadly that it would include many types of birth control, including oral contraception.', 'http://www.speaker.gov/blog/', 'The Gavel Â» Blog Archive Â» Bush Administration Tries to Redefine Contraception as Abortion', '', NULL, 0, '2008-07-17 10:49:23', 8, 76, 'related'),
(102, 'The majority of Americans oppose this out of touch position that redefines contraception as abortion', 'http://www.speaker.gov/blog/', 'The Gavel Â» Blog Archive Â» Bush Administration Tries to Redefine Contraception as Abortion', '', NULL, 0, '2008-07-17 10:50:28', 8, 77, 'related'),
(103, 'Time and again this Administration has jeopardized womenâ€™s access to essential family planning services for purely ideological reasons.', 'http://www.speaker.gov/blog/', 'The Gavel Â» Blog Archive Â» Bush Administration Tries to Redefine Contraception as Abortion', '', NULL, 0, '2008-07-17 10:54:00', 8, 76, 'related'),
(104, 'Methods for automatically classifying words according to their contexts of use have both scientific and prac- tical interest.', 'http://mashmaker.intel-research.net/rob/server/pdfs/da/18/pdf-1.html', 'Page 1', 'DISTRIBUTIONAL CLUSTERING OF ENGLISH WORDS', NULL, 0, '2008-07-18 11:00:26', 8, 78, 'related'),
(105, 'From the practical point of view, word classification addresses questions of data sparseness and generalization in statistical lan- guage models, particularly models for deciding among alternative analyses proposed by a grammar.', 'http://mashmaker.intel-research.net/rob/server/pdfs/da/18/pdf-1.html', 'Page 1', 'DISTRIBUTIONAL CLUSTERING OF ENGLISH WORDS', NULL, 0, '2008-07-18 11:05:47', 8, 79, 'related'),
(106, 'And God said, Behold', 'http://mashmaker.intel-research.net/beth/', 'testing', '', NULL, 0, '2008-07-22 11:43:46', 1, 2, 'related'),
(107, 'user_path is missing because you don''t have a named route for user. In a conventional rails 2.0 restful application the controller for User would be named UsersController, and in the config/routes.rb you''d have ActionController::Routing::Routes.draw do |map| map.resources :users which would generate a bunch of named routes and path/url helpers including the missing user_path ', 'http://www.ruby-forum.com/topic/141825', 'Rails 2.0.2 upgrade -> undefined method `user_path'' - Ruby Forum', '', NULL, 0, '2008-07-22 11:43:46', 1, 80, 'related'),
(108, 'hat was the night the invading Nazis came to take her away from her Ukrainian home', 'http://www.cnn.com/2008/WORLD/europe/07/11/holocaust.reunion/index.html', 'Holocaust siblings meet after 66 years - CNN.com', '', NULL, 0, '2008-07-22 11:43:46', 8, 1, 'related'),
(109, 'Obama -- who has made ending the Iraq war a cornerstone of his run for office -- engaged in what were described as productive talks with al-Maliki during a trip to Iraq. ', 'http://www.cnn.com/2008/POLITICS/07/21/obama.mideast/index.html', 'Iraq leader, Obama discuss future troop pullout - CNN.com', '', NULL, 0, '2008-07-22 11:43:46', 8, 1, 'related'),
(110, 'Partials ("partial views") are fragments of RHTML that can be inserted into a view. They exist to make the view logic simpler. The most typical usage is rendering a list of items. The view logic for each item is encapulated in a partial, and the view simply iterates through them, perhaps like this: ', 'http://www.pointstorm.com/~gavin/partials-doc/classes/ActionView/Partials.html', 'Module: ActionView::Partials', '', NULL, 0, '2008-07-22 11:43:46', 1, 81, 'related'),
(111, 'A new barrier along the sides of the 4,200-foot-long span needs to be formidable enough to stop or slow down people who want to leap off the edge -- but not so formidable that it adds dangerous stress to a structure that on three occasions was closed because of high winds. ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'LETHAL BEAUTY / THE ENGINEERING CHALLENGE: A suicide barrier must be effective and safe. The sixth in a seven-part series on the', '', NULL, 0, '2008-07-22 11:43:46', 1, 82, 'related'),
(112, '"We came to a conclusion that from the standpoint of risk, the bridge is more vulnerable to wind than to earthquakes," says Mark Ketchum, a vice president at OPAC Consulting Engineers, who in the late 1980s conducted seismic studies of the bridge for another firm. ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'LETHAL BEAUTY / THE ENGINEERING CHALLENGE: A suicide barrier must be effective and safe. The sixth in a seven-part series on the', '', NULL, 0, '2008-07-22 11:43:46', 1, 83, 'related'),
(113, 'For instance, Mulligan points out that a design based on thin vertical rods, as favored in the ''70s, could be a safety hazard for bicyclists, who use the bridge in vastly greater numbers today. The reason? Their handlebars could get snagged in the rods. ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'LETHAL BEAUTY / THE ENGINEERING CHALLENGE: A suicide barrier must be effective and safe. The sixth in a seven-part series on the', '', NULL, 0, '2008-07-22 11:43:46', 1, 84, 'related'),
(114, 'One thousand, two hundred eighteen dead. The lives of families devastated.', 'http://www.sfgate.com/lethalbeauty/', 'SFGate: Lethal Beauty', '', NULL, 0, '2008-07-22 11:43:46', 1, 85, 'related'),
(115, 'The structures were a block apart, but the Ellington bridge was the favorite of the suicide-prone. When a suicide barrier was installed on the Ellington bridge in 1986, suicides there stopped, and the rate of suicide at the Taft bridge did not increase. ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'LETHAL BEAUTY / The Toronto example: How one city overcame bureaucracy. The fifth in a seven-part series on the Golden Gate Brid', '', NULL, 0, '2008-07-22 11:43:46', 1, 86, 'related'),
(116, 'In recent years, there had been close to 20 suicides there a year. Since the barrier was built, there have been none. ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'LETHAL BEAUTY / The Toronto example: How one city overcame bureaucracy. The fifth in a seven-part series on the Golden Gate Brid', '', NULL, 0, '2008-07-22 11:43:46', 1, 87, 'related'),
(117, 'In 1964, Motto allied himself with San Francisco''s Suicide Prevention Center, and was invited by its members to argue their case before the bridge district''s security committee. ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'LETHAL BEAUTY / The Advocate', '', NULL, 0, '2008-07-22 11:43:46', 1, 88, 'related'),
(118, 'No matter how light the suicide structure would be, he believes, it would create a tunnel effect for those looking down the roadway -- a "wall" that would close the view. ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'LETHAL BEAUTY / The Critic', '', NULL, 0, '2008-07-22 11:43:46', 1, 89, 'related'),
(119, 'He has visited the Eiffel Tower and Empire State Building and finds their suicide barriers "oppressive."', 'http://www.sfgate.com/cgi-bin/article.cgi', 'LETHAL BEAUTY / The Critic', '', NULL, 0, '2008-07-22 11:43:46', 1, 90, 'related'),
(120, 'Suicide by bridge is gruesome, and death is almost certain. People have survived the fall, but not many. You might survive if you hit the water feet first and come in at a slight angle. ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'LETHAL BEAUTY / No easy death: Suicide by bridge is gruesome, and death is almost certain. The fourth in a seven-part series on ', '', NULL, 0, '2008-07-22 11:43:46', 1, 91, 'related'),
(121, 'Which means you die one of two ways, or a combination of both. One, you hit the water and the impact kills you. Sometimes the jumper is knocked unconscious. Other times, the jumper survives for a time. The person can be seen flailing about in the water, trying to stay afloat, only to succumb to the extensive internal bleeding. Death can take seconds or minutes. Two, you drown. You hit the water going fast, and your body plunges in deep. Conscious or otherwise, you breathe in saltwater and asphyxiate. ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'LETHAL BEAUTY / No easy death: Suicide by bridge is gruesome, and death is almost certain. The fourth in a seven-part series on ', '', NULL, 0, '2008-07-22 11:43:46', 1, 92, 'related'),
(122, 'For finding and retrieving bodies, time is of the essence. The sea reclaims bodies quickly. Fish eat them. Not just sharks, but little fish. They eat the eyes and other tender parts. As the body decays and opens up, all manner of sea creatures move in to feed. Eventually, the body comes apart. ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'LETHAL BEAUTY / No easy death: Suicide by bridge is gruesome, and death is almost certain. The fourth in a seven-part series on ', '', NULL, 0, '2008-07-22 11:43:46', 1, 93, 'related'),
(123, '"I don''t know that a barrier would do much good," he said. "I think people will find other ways to kill themselves, and it might mean they do something that puts someone else in danger, like jumping off a building or intentionally driving their car into traffic." ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'LETHAL BEAUTY / No easy death: Suicide by bridge is gruesome, and death is almost certain. The fourth in a seven-part series on ', '', NULL, 0, '2008-07-22 11:43:46', 1, 94, 'related'),
(124, 'One-thousand, two-hundred eighteen dead. The lives of families devastated. Sixty-eight years of debate about a suicide barrier.', 'http://www.sfgate.com/cgi-bin/article.cgi', 'Lethal Beauty / The Allure: Beauty and an easy route to death have long made the Golden Gate Bridge a magnet for suicides', '', NULL, 0, '2008-07-22 11:43:46', 1, 85, 'related'),
(125, 'nine out of 10 people prevented from jumping off the Golden Gate were still alive years later or had died of natural causes, despite the rationale that a barrier would prompt them only to "go somewhere else to end it."', 'http://www.canada.com/reginaleaderpost/news/story.html?id=b305d57c-745f-431c-b87f-d31a69e2494b', 'A bridge too deadly?', '', NULL, 0, '2008-07-22 11:43:46', 1, 95, 'related'),
(126, 'Opponents of a fence are wary of altering the appearance of an iconic structure that many local residents refer to as"my bridge." But their reluctance challenges San Francisco''s progressive reputation. The bridge district this year found $25 million to install a movable median between two-way traffic on the bridge, where a total of five head-on collisions have claimed a single life since 1997.', 'http://www.canada.com/reginaleaderpost/news/story.html?id=b305d57c-745f-431c-b87f-d31a69e2494b', 'A bridge too deadly?', '', NULL, 0, '2008-07-22 11:43:46', 1, 96, 'related'),
(127, 'The Golden Gate Bridge is the world''s No. 1 suicide magnet, in part because it makes suicide so easy. People jump and kill themselves there, an average of 19 a year. In the peak year, 1977, there were 40 suicides. Some dive not expecting obscurity or oblivion but a kind of grace -- a welcoming body of water that inducts the jumper into nature. ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'Lethal Beauty / The Allure: Beauty and an easy route to death have long made the Golden Gate Bridge a magnet for suicides', '', NULL, 0, '2008-07-22 11:43:46', 1, 97, 'related'),
(128, 'Eighty-seven percent are Bay Area residents -- exploding the myth that people flock from around the world to die here. ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'Lethal Beauty / The Allure: Beauty and an easy route to death have long made the Golden Gate Bridge a magnet for suicides', '', NULL, 0, '2008-07-22 11:43:46', 1, 98, 'related'),
(129, 'Three to 1, they''re men', 'http://www.sfgate.com/cgi-bin/article.cgi', 'Lethal Beauty / The Allure: Beauty and an easy route to death have long made the Golden Gate Bridge a magnet for suicides', '', NULL, 0, '2008-07-22 11:43:46', 1, 99, 'related'),
(130, 'In 1978 Seiden published a study of 515 people who were prevented from jumping off the bridge. He found that only 6 percent went on to kill themselves. ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'Lethal Beauty / The Allure: Beauty and an easy route to death have long made the Golden Gate Bridge a magnet for suicides', '', NULL, 0, '2008-07-22 11:43:46', 1, 95, 'related'),
(131, 'For Eve Meyer, executive director of San Francisco Suicide Prevention and a passionate advocate for a suicide barrier, accessibility is the biggest factor in making the bridge a magnet for death. "It''s something you can accomplish relatively easily," she says, "and that''s what makes it so dangerous." ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'Lethal Beauty / The Allure: Beauty and an easy route to death have long made the Golden Gate Bridge a magnet for suicides', '', NULL, 0, '2008-07-22 11:43:46', 1, 100, 'related'),
(132, 'In his original plans, chief engineer Joseph Strauss considered the bridge''s potential as a suicide site and designed railings 5 1/2 feet high. On May 7, 1936, a year before the opening of the bridge, Strauss boasted to the San Francisco Call-Bulletin that the bridge was "practically suicide-proof." ', 'http://www.sfgate.com/cgi-bin/article.cgi', 'Lethal Beauty / The Allure: Beauty and an easy route to death have long made the Golden Gate Bridge a magnet for suicides', '', NULL, 0, '2008-07-22 11:43:46', 1, 101, 'related'),
(133, 'You usually want to pass some information into the partial, e.g. a todo item to be displayed. There are three ways to achieve this. In order of complexity, they are: instance variables; passing a single object; and assigning local variables.', 'http://www.pointstorm.com/~gavin/partials-doc/classes/ActionView/Partials.html', 'Module: ActionView::Partials', '', NULL, 0, '2008-07-22 11:43:46', 1, 102, 'related'),
(134, 'His proposal to withdraw U.S. combat forces over a 16-month period still faces serious questions, including from some of the commanders who might be asked to implement it if he is elected. ', 'http://www.washingtonpost.com/wp-dyn/content/article/2008/07/21/AR2008072102851.html', 'Obama Makes War Gains - washingtonpost.com', '', NULL, 0, '2008-07-22 11:43:46', 1, 103, 'related'),
(135, 'Iraqi prime minister had seemingly all but endorsed Obama''s relatively rapid timeline for getting out. ', 'http://www.washingtonpost.com/wp-dyn/content/article/2008/07/21/AR2008072102851.html', 'Obama Makes War Gains - washingtonpost.com', '', NULL, 0, '2008-07-22 11:43:46', 1, 104, 'related'),
(136, 'McCain, campaigning in Maine, was blistering in his criticism of Obama on Monday, saying that his rival has been "completely wrong" on Iraq, "has no military experience whatsoever" and arguing again that any withdrawal from Iraq must be based on conditions on the ground. ', 'http://www.washingtonpost.com/wp-dyn/content/article/2008/07/21/AR2008072102851.html', 'Obama Makes War Gains - washingtonpost.com', '', NULL, 0, '2008-07-22 11:43:46', 1, 105, 'related'),
(137, 'The Republican''s campaign advisers noted that their candidate has also embraced a withdrawal timetable for Iraq. In a recent speech, he said his goal would be to remove all U.S. combat forces by the end of his first term as president. ', 'http://www.washingtonpost.com/wp-dyn/content/article/2008/07/21/AR2008072102851.html', 'Obama Makes War Gains - washingtonpost.com', '', NULL, 0, '2008-07-22 11:43:46', 1, 106, 'related'),
(138, 'Despite seeing a huge rise in sales of its Macintosh computers recently, the Cupertino, Calif., company projected a drop in sales and profit growth in the current quarter. ', 'http://www.latimes.com/business/la-fi-apple22-2008jul22,0,6052157.story', 'Apple stock tumbles despite jump in earnings - Los Angeles Times', '', NULL, 0, '2008-07-22 11:43:46', 1, 107, 'related');
INSERT INTO `snippets` (`id`, `txt`, `url`, `pagetitle`, `title`, `author`, `source_id`, `created_at`, `user_id`, `point_id`, `howlinked`) VALUES 
(139, 'Investors also fretted about the health of Chief Executive Steve Jobs, who looked gaunt during a public event last month.', 'http://www.latimes.com/business/la-fi-apple22-2008jul22,0,6052157.story', 'Apple stock tumbles despite jump in earnings - Los Angeles Times', '', NULL, 0, '2008-07-22 11:43:46', 1, 108, 'related'),
(140, 'In 2004, the Apple co-founder said he had pancreatic cancer but, thanks to surgery, had recovered.', 'http://www.latimes.com/business/la-fi-apple22-2008jul22,0,6052157.story', 'Apple stock tumbles despite jump in earnings - Los Angeles Times', '', NULL, 0, '2008-07-22 11:43:46', 1, 109, 'related'),
(141, 'tens of billions of dollars of market value rests on Steve''s remaining healthy and at the helm of Apple for many years', 'http://www.alleyinsider.com/2008/5/does_apple_s_steve_jobs_have_cancer_again_', 'Does Apple''s Steve Jobs Have Cancer Again?*', '', NULL, 0, '2008-07-22 11:43:46', 1, 110, 'related'),
(142, 'Steve appeared dangerously thin', 'http://www.alleyinsider.com/2008/5/does_apple_s_steve_jobs_have_cancer_again_', 'Does Apple''s Steve Jobs Have Cancer Again?*', '', NULL, 0, '2008-07-22 11:43:46', 1, 111, 'related'),
(143, 'Given that Steve did not believe that that cancer needed to be disclosed publicly until after the fact, however, it also seems possible that the weight loss could be an indication that Steve''s cancer has reappeared.', 'http://www.alleyinsider.com/2008/5/does_apple_s_steve_jobs_have_cancer_again_', 'Does Apple''s Steve Jobs Have Cancer Again?*', '', NULL, 0, '2008-07-22 11:43:46', 1, 112, 'related'),
(144, 'Even if Steve is fine, which we hope he is, this episode should make it more obvious to Apple that the company needs to develop and articulate a clear succession and Steve Jobs-diversification plan.', 'http://www.alleyinsider.com/2008/5/apple_aapl_crushed_again_on_concerns_about_steve_jobs_health', 'Apple (AAPL) Weakness and Steve Jobs'' Scare Reveal Need For a Better Apple Plan', '', NULL, 0, '2008-07-22 11:43:46', 1, 113, 'related'),
(145, 'No matter how remote the possibility of Mr Jobs standing down might be, some investors would be happier if Mr Ive was named officially as the Apple CEOâ€™s successor to avoid future doubt.', 'http://apple20.blogs.fortune.cnn.com/2007/12/08/will-jonathan-ive-replace-apples-steve-jobs/', 'FORTUNE: Apple 2.0 Will Jonathan Ive replace Appleâ€™s Steve Jobs? Â«', '', NULL, 0, '2008-07-22 11:43:46', 1, 114, 'related'),
(146, 'It also cites "multiple sources" who''ve met Steve in recent weeks and are "troubled by his thin appearance."', 'http://www.alleyinsider.com/2008/7/steve-jobs-health-worries-won-t-go-away-time-for-a-succession-plan-aapl-', 'Steve Jobs'' Health Worries Won''t Go Away. Time For A Succession Plan (AAPL)', '', NULL, 0, '2008-07-22 11:43:46', 1, 111, 'related'),
(147, 'Ive, 41, is probably the least likely of the leading contenders to take the job.', 'http://apple20.blogs.fortune.cnn.com/2008/06/24/after-steve-jobs-handicapping-apples-back-bench/', 'FORTUNE: Apple 2.0 After Steve Jobs: Handicapping Appleâ€™s back bench Â«', '', NULL, 0, '2008-07-22 11:43:46', 1, 115, 'related'),
(148, 'Recent reports claim Apple''s Jonathan Ive (designer of the iMac) has purchased a mansion in the UK,', 'http://news.softpedia.com/news/Watchers-Claim-Apple-Needs-a-CEO-Succession-Plan-88435.shtml', 'Watchers Claim Apple Needs a CEO Succession Plan - Rumors about Jobs health are raising questions as to who would best fit the C', '', NULL, 0, '2008-07-21 22:38:19', 1, 116, 'related'),
(149, 'Hagee believes an end-time narrative that requires Jews to relocate to Israel before Jesus returns and they convert to Christianity.', 'http://blog.washingtonpost.com/the-trail/2008/07/22/lieberman_appearance_at_hagee.html', 'Lieberman Appearance at Hagee Conference Sparks Objections | The Trail | washingtonpost.com', '', NULL, 0, '2008-07-22 13:17:00', 1, 117, 'related'),
(150, 'Sen. Joe Lieberman, an independent from Connecticut, is scheduled to speak at the annual conference of Christians United for Israel, a group Hagee founded to gather evangelical Christian economic and political support for Israel.', 'http://blog.washingtonpost.com/the-trail/2008/07/22/lieberman_appearance_at_hagee.html', 'Lieberman Appearance at Hagee Conference Sparks Objections | The Trail | washingtonpost.com', '', NULL, 0, '2008-07-22 13:17:30', 1, 117, 'related'),
(151, 'And God called the dry land Earth; and the gathering together of the waters called he Seas: and God saw that it was good. 11: And God said, Let the earth bring forth grass, t', 'http://mashmaker.intel-research.net/beth/', 'testing', '', NULL, 0, '2008-07-23 10:50:51', 8, 2, 'related'),
(152, 'And God said, Let us make man in our image', 'http://mashmaker.intel-research.net/beth/', 'testing', '', NULL, 0, '2008-07-23 11:02:31', 8, 118, 'related'),
(153, 'It was only a matter of time before the Scrabble-Scrabulous feud came to a head, and that breaking point has now been reached. Hasbro said today that it has filed suit in the Southern District of New York against Rajat Agarwalla, Jayant Agarwalla, and RJ Softwares, better known as the creators of the popular Facebook application Scrabulous. As part of the suit, Hasbro said that it has served Facebook with yet another take-down notice for the application due to copyright infringement. ', 'http://www.gamespot.com/news/6194976.html', 'Scrabble-Scrabulous standoff spells L-A-W-S-U-I-T - News at GameSpot', '', NULL, 0, '2008-07-24 15:50:26', 1, 119, 'related'),
(154, 'The reason for the gamemaker''s sudden ire toward the application, which draws more than 500,000 daily average users, can be attributed to the launch of the official Scrabble online game through EA''s Pogo.com and Facebook this month. Currently, the official Scrabble Facebook application logs just under 20,000 users globally. ', 'http://www.gamespot.com/news/6194976.html', 'Scrabble-Scrabulous standoff spells L-A-W-S-U-I-T - News at GameSpot', '', NULL, 0, '2008-07-24 15:52:38', 1, 120, 'related'),
(155, 'Git doesn''t allow a merge if you have uncommited changes, either your changes are irrelevant and you want to "git reset --hard", or they are, and you want to commit (and perhaps use "rebase"), or stash them. ', 'http://marc.info/', '''Re: fatal: Entry ''xxx'' not uptodate. Cannot merge.'' - MARC', '', NULL, 0, '2008-07-24 17:03:33', 1, 121, 'related'),
(156, 'Git doesn''t allow a merge if you have uncommited changes, either your changes are irrelevant and you want to "git reset --hard", or they are, and you want to commit (and perhaps use "rebase"), or stash them. ', 'http://marc.info/', '''Re: fatal: Entry ''xxx'' not uptodate. Cannot merge.'' - MARC', '', NULL, 0, '2008-07-24 17:03:51', 1, 121, 'related'),
(157, 'Git doesn''t allow a merge if you have uncommited changes, either your changes are irrelevant and you want to "git reset --hard", or they are, and you want to commit (and perhaps use "rebase"), or stash them. ', 'http://marc.info/', '''Re: fatal: Entry ''xxx'' not uptodate. Cannot merge.'' - MARC', '', NULL, 0, '2008-07-24 17:03:58', 1, 122, 'related'),
(158, 'Git doesn''t allow a merge if you have uncommited changes, either your changes are irrelevant and you want to "git reset --hard", or they are, and you want to commit (and perhaps use "rebase"), or stash them. ', 'http://marc.info/', '''Re: fatal: Entry ''xxx'' not uptodate. Cannot merge.'' - MARC', '', NULL, 0, '2008-07-24 17:05:02', 1, 122, 'related'),
(159, 'You can also use scripts from the mysql prompt by using the source command or \\. command', 'http://dev.mysql.com/doc/refman/5.0/en/batch-mode.html', 'MySQL :: MySQL 5.0 Reference Manual :: 3.5 Using mysql in Batch Mode', '', NULL, 0, '2008-07-24 19:18:26', 1, 123, 'related'),
(160, 'Does Labour face defeat at the next general election - or obliteration? The result from Glasgow East early this morning was more than simply terrible for Gordon Brown: it raises the spectre of a parliamentary wipe-out from which his party would struggle to recover.', 'http://www.guardian.co.uk/politics/2008/jul/25/glasgoweast.byelections3', 'For Brown, prospect is loss of leadership - and his own seat | Politics | The Guardian', '', NULL, 0, '2008-07-24 19:24:17', 1, 124, 'related'),
(161, 'This was Labour''s third safest seat in Scotland and its 25th safest in Britain, yet it has been lost easily to the Scottish National party, which started the short campaign more than 13,000 votes behind. ', 'http://www.guardian.co.uk/politics/2008/jul/25/glasgoweast.byelections3', 'For Brown, prospect is loss of leadership - and his own seat | Politics | The Guardian', '', NULL, 0, '2008-07-24 19:24:52', 1, 125, 'related'),
(162, 'Every part of Britain has turned against the party. The opinion polls have been showing it for months. Last night brought the proof.', 'http://www.guardian.co.uk/politics/2008/jul/25/glasgoweast.byelections3', 'For Brown, prospect is loss of leadership - and his own seat | Politics | The Guardian', '', NULL, 0, '2008-07-24 19:26:58', 1, 126, 'related'),
(163, 'The result from Glasgow East early this morning was more than simply terrible for Gordon Brown: it raises the spectre of a parliamentary wipe-out from which his party would struggle to recover.', 'http://www.guardian.co.uk/politics/2008/jul/25/glasgoweast.byelections3', 'For Brown, prospect is loss of leadership - and his own seat | Politics | The Guardian', '', NULL, 0, '2008-07-24 19:27:38', 1, 127, 'related'),
(164, 'The quake, estimated at 5.4 magnitude (reduced from an initial estimate of 5.8), was centered 35 east of downtown Los Angeles in Chino Hills, just south of Pomona in San Bernardino county. It was felt as far east as Las Vegas and as far south as San Diego. ', 'http://www.nytimes.com/2008/07/30/us/30quake.html', 'Earthquake Rattles Southern California - NYTimes.com', '', NULL, 0, '2008-07-29 14:12:44', 1, 128, 'related'),
(165, 'There were no immediate reports of major injuries or structural damage.', 'http://www.nytimes.com/2008/07/30/us/30quake.html', 'Earthquake Rattles Southern California - NYTimes.com', '', NULL, 0, '2008-07-29 14:13:12', 1, 129, 'related'),
(166, 'Dogged by a series of corruption scandals, Israeli Prime Minister Ehud Olmert said on Wednesday he would resign once his ruling Kadima party chooses a new leader in a September election.', 'http://www.reuters.com/article/latestCrisis/idUSL0225065', 'Excerpts of Olmert''s speech pledging to resign | Reuters', '', NULL, 0, '2008-07-30 14:43:06', 1, 130, 'related'),
(167, 'Ehud Olmert says he will step down as Israel''s prime minister immediately after his Kadima Party selects a new leader at a party convention on September 17.', 'http://www.voanews.com/english/2008-07-30-voa51.cfm', 'VOA News - Olmert to Quit as Israeli PM in September', '', NULL, 0, '2008-07-30 14:44:09', 1, 130, 'related'),
(168, 'The earthquake, which registered a 5.4 magnitude, was centered near Chino Hills in San Bernardino County and was felt as far east as Las Vegas and south to San Diego.', 'http://www.nytimes.com/2008/07/30/us/30quake.html', 'Earthquake Rattles Southern California - NYTimes.com', '', NULL, 0, '2008-07-31 12:21:51', 1, 128, 'related'),
(169, 'Still, cellphone lines were jammed throughout the region as people frantically made calls in the immediate moments after the jolt.', 'http://www.nytimes.com/2008/07/30/us/30quake.html', 'Earthquake Rattles Southern California - NYTimes.com', '', NULL, 0, '2008-07-31 12:26:51', 1, 131, 'related'),
(170, 'the roughly 50 aftershocks by midafternoon, one of which registered at 3.8. The Los Angeles City Council, meeting downtown, adjourned briefly to regroup after the event. ', 'http://www.nytimes.com/2008/07/30/us/30quake.html', 'Earthquake Rattles Southern California - NYTimes.com', '', NULL, 0, '2008-07-31 12:53:57', 1, 132, 'related'),
(171, 'lights in the firmament of the h', 'http://mashmaker.intel-research.net/beth/', 'testing', '', NULL, 0, '2008-07-31 16:40:07', 8, 2, 'related'),
(172, 'no evidence supports a claim that Obama is currently, or ever has been, a Muslim (radical or otherwise)', 'http://www.snopes.com/politics/obama/muslim.asp', 'snopes.com: Who Is Barack Obama?', '', NULL, 0, '2008-08-01 18:03:58', 1, 133, 'related'),
(173, 'Barack Obama, 45, served as an Illinois state senator for several years,', 'http://www.snopes.com/politics/obama/muslim.asp', 'snopes.com: Who Is Barack Obama?', '', NULL, 0, '2008-08-01 18:05:05', 1, 134, 'related'),
(174, 'Barack Hussein Obama was born in Honolulu, Hawaii, to Barack Hussein Obama, Sr., a black MUSLIM from Nyangoma-Kogel, Kenya and Ann Dunh am, a white ATHEIST from Wichita, Kansas. Obama''s parents met at the University of Hawaii. ', 'http://www.snopes.com/politics/obama/muslim.asp', 'snopes.com: Who Is Barack Obama?', '', NULL, 0, '2008-08-01 18:06:21', 1, 135, 'related'),
(175, 'Barack Hussein Obama was born in Honolulu, Hawaii, to Barack Hussein Obama, Sr., a black MUSLIM from Nyangoma-Kogel, Kenya and Ann Dunh am, a white ATHEIST from Wichita, Kansas. Obama''s parents met at the University of Hawaii. ', 'http://www.snopes.com/politics/obama/muslim.asp', 'snopes.com: Who Is Barack Obama?', '', NULL, 0, '2008-08-01 18:06:41', 1, 136, 'related'),
(176, 'In his 2006 book, The Audacity of Hope, Obama elaborated on his early schooling, explaining that he attended both Catholic and Muslim schools in Indonesia â€” not out of any particular religious affiliation, but because his mother wanted him to obtain the best education possible under the circumstances: ', 'http://www.snopes.com/politics/obama/muslim.asp', 'snopes.com: Who Is Barack Obama?', '', NULL, 0, '2008-08-01 18:10:24', 1, 137, 'related'),
(177, 'Barack Obama''s parents divorced when he was only two years old, and his father then moved thousands of miles away, from Hawaii to Connecticut, so he couldn''t have received much of an "introduction to Islam" from his (biological) father: ', 'http://www.snopes.com/politics/obama/muslim.asp', 'snopes.com: Who Is Barack Obama?', '', NULL, 0, '2008-08-01 18:12:30', 1, 138, 'related'),
(178, '"It''s not (an) Islamic school. It''s general," Winadijanto said. "There is a lot of Christians, Buddhists, also Confucian. ... So that''s a mixed school." ', 'http://www.snopes.com/politics/obama/muslim.asp', 'snopes.com: Who Is Barack Obama?', '', NULL, 0, '2008-08-01 18:16:30', 1, 140, 'related'),
(179, 'Much has been said about the layers of attack in this ad, but the focus on Hilton & Spears (which Ruffini gives a ''triple'' rating) overshadows the ''issue-based'' attack over Obama meaning "New Taxes" and more "Foreign Oil" with the text of ''foreign'' next to Obama''s face. ', 'http://www.dailykos.com/storyonly/2008/8/1/12233/32515', 'Daily Kos: State of the Nation', '', NULL, 0, '2008-08-01 18:21:06', 1, 141, 'related'),
(180, ' It''s true that a coal/gas tax would raise electric rates, but so would a cap-and-trade program to restrict carbon emissions. Cap-and-trade is an idea that both McCain and Obama support, in different forms. Neither candidate characterizes cap-and-trade as a "tax."', 'http://www.factcheck.org/elections-2008/obamas_celebrity_cred.html', 'FactCheck.org: Obama''s Celebrity Cred', '', NULL, 0, '2008-08-01 18:22:26', 1, 142, 'related'),
(181, 'We asked the McCain campaign if it had any other information on which to base this "taxes on electricity" claim, and we received no response. We looked, but could find no instance of Obama making mention of a tax on electricity or any other reference to a "dirty energy" tax. In any case, no such policy proposals are currently part of his public platform.', 'http://www.factcheck.org/elections-2008/obamas_celebrity_cred.html', 'FactCheck.org: Obama''s Celebrity Cred', '', NULL, 0, '2008-08-01 18:25:08', 1, 143, 'related'),
(182, 'The McCain campaign sent reporters a set of "ad facts" to accompany the new spot. But the campaign''s sole source for its charge that Obama wants to raise taxes on electricity is a short Feb. 19 interview that Obama gave to Carlos Guerra, a reporter with the San Antonio Express-News. Obama does in fact say, "What we ought to tax is dirty energy, like coal and, to a lesser extent, natural gas." But that quote is out of context. Obama and Guerra are discussing possible ways to fund education. Here''s the pertinent passage, in full:', 'http://www.factcheck.org/elections-2008/obamas_celebrity_cred.html', 'FactCheck.org: Obama''s Celebrity Cred', '', NULL, 0, '2008-08-01 18:26:51', 1, 143, 'related'),
(183, 'In 1995, State Senator Alice Palmer introduced her chosen successor, Barack Obama, to a few of the districtâ€™s influential liberals at the home of two well known figures on the local left: William Ayers and Bernardine Dohrn. While Ayers and Dohrn may be thought of in Hyde Park as local activists, theyâ€™re better known nationally as two of the most notorious â€” and unrepentant â€” figures from the violent fringe of the 1960s anti-war movement. ', 'http://www.politico.com/news/stories/0208/8630.html', 'Obama once visited ''60s radicals - Ben Smith - Politico.com', '', NULL, 0, '2008-08-01 18:30:31', 1, 144, 'related'),
(184, 'Dr. Young described Obama and Ayers as â€œfriends,â€', 'http://www.politico.com/news/stories/0208/8630.html', 'Obama once visited ''60s radicals - Ben Smith - Politico.com', '', NULL, 0, '2008-08-01 18:32:03', 1, 145, 'related'),
(185, 'but thereâ€™s no evidence their relationship is more than the casual friendship of two men who occupy overlapping Chicago political circles and who served together on the board of a Chicago foundation.', 'http://www.politico.com/news/stories/0208/8630.html', 'Obama once visited ''60s radicals - Ben Smith - Politico.com', '', NULL, 0, '2008-08-01 18:32:22', 1, 146, 'related'),
(186, 'Hillary Rodham Clinton, for instance, interned at a radical San Francisco law firm while in law school. ', 'http://www.politico.com/news/stories/0208/8630.html', 'Obama once visited ''60s radicals - Ben Smith - Politico.com', '', NULL, 0, '2008-08-01 18:33:25', 1, 147, 'related'),
(187, 'Part of the leadership of the Weather Underground, Dohrn was considered the organizationâ€™s figurehead.', 'http://www.pbs.org/independentlens/weatherunderground/today.html', 'Independent Lens . THE WEATHER UNDERGROUND . The Weathermen Today | PBS', '', NULL, 0, '2008-08-01 18:41:19', 1, 148, 'related'),
(188, 'Today, Dohrn is an associate professor and director at Northwestern University''s Children and Justice Center. ', 'http://www.pbs.org/independentlens/weatherunderground/today.html', 'Independent Lens . THE WEATHER UNDERGROUND . The Weathermen Today | PBS', '', NULL, 0, '2008-08-01 18:42:02', 1, 149, 'related'),
(189, 'Bill Ayers A central figure in the Weathermen, Ayers lived underground for ten years, an experience he wrote about in his memoir, Fugitive Days. ', 'http://www.pbs.org/independentlens/weatherunderground/today.html', 'Independent Lens . THE WEATHER UNDERGROUND . The Weathermen Today | PBS', '', NULL, 0, '2008-08-01 18:42:54', 1, 150, 'related'),
(190, 'Learn more about the former Weathermen featured in THE WEATHER UNDERGROUND, and find out what theyâ€™re doing now. ', 'http://www.pbs.org/independentlens/weatherunderground/today.html', 'Independent Lens . THE WEATHER UNDERGROUND . The Weathermen Today | PBS', '', NULL, 0, '2008-08-01 18:46:08', 1, 151, 'related'),
(191, 'What a coincidence. Remember when Obama lied about his â€œuncleâ€ liberating â€œAuschwitzâ€? Never mind the ignobility of the ignorance underlying the lie; both Juanita at our blog, and Larry Johnson at Noquarter, questioned the very existance of any such uncle. At the time, the Obama goons clarified that the One had â€œmispokenâ€ (where were all the Bosnia journalists?) because the camp in question was Buchenwald, and the uncle was Obamaâ€™s â€œgreat-uncle.â€ Larry at Noquarter did some digging and found it implossible that any such Obama relation could have been at Buchenwald, since the only great-uncle in Obamaâ€™s possession supposedly enlisted in the US. Navy.', 'http://www.stop-obama.org/', 'Stop-Obama Â» Obama To Jews. About that Uncleâ€¦', '', NULL, 0, '2008-08-01 18:59:27', 1, 152, 'related'),
(192, 'The only political force to liberate actual victims of death-extermination camps, were the Soviets - about 80% of the entire Nazi camp system (including labor, concentration, and extermination). While it is historically accurate that Canadians, Americans, and the British came upon â€œlabor and concentration campsâ€, these were mostly in Germany proper, where Germans exploited an assortment of nationalities as slave labor for purposes of building a greater Germany.', 'http://www.stop-obama.org/', 'Stop-Obama Â» Obama To Jews. About that Uncleâ€¦', '', NULL, 0, '2008-08-01 19:01:41', 1, 153, 'related'),
(193, 'That''s when Hillary Clinton blasted Obama for having represented "your contributor, Rezko, in his slum landlord business in inner-city Chicago."', 'http://www.suntimes.com/news/watchdogs/757340,CST-NWS-watchdog24.article', '8 things you need to know about Obama, Rezko :: CHICAGO SUN-TIMES :: The Watchdogs', '', NULL, 0, '2008-08-01 19:06:53', 1, 154, 'related'),
(194, 'Among his earliest supporters: Rezko. Two Rezko companies donated a total of $2,000.', 'http://www.suntimes.com/news/watchdogs/757340,CST-NWS-watchdog24.article', '8 things you need to know about Obama, Rezko :: CHICAGO SUN-TIMES :: The Watchdogs', '', NULL, 0, '2008-08-01 19:07:48', 1, 155, 'related'),
(195, 'Obama was elected in 1996 -- representing a district that included 11 of Rezko''s 30 low-income housing projects.', 'http://www.suntimes.com/news/watchdogs/757340,CST-NWS-watchdog24.article', '8 things you need to know about Obama, Rezko :: CHICAGO SUN-TIMES :: The Watchdogs', '', NULL, 0, '2008-08-01 19:08:37', 1, 156, 'related'),
(196, '6. In 2003, Obama announced he was running for the U.S. Senate, and Rezko -- a member of his campaign finance committee -- held a lavish fund-raiser June 27, 2003, at his Wilmette mansion.', 'http://www.suntimes.com/news/watchdogs/757340,CST-NWS-watchdog24.article', '8 things you need to know about Obama, Rezko :: CHICAGO SUN-TIMES :: The Watchdogs', '', NULL, 0, '2008-08-01 19:09:03', 1, 155, 'related'),
(197, 'Rezko -- a member of his campaign finance committee', 'http://www.suntimes.com/news/watchdogs/757340,CST-NWS-watchdog24.article', '8 things you need to know about Obama, Rezko :: CHICAGO SUN-TIMES :: The Watchdogs', '', NULL, 0, '2008-08-01 19:09:40', 1, 157, 'related'),
(198, 'Rezko was indicted on charges he solicited kickbacks from companies seeking state pension business under his friend Gov. Blagojevich.', 'http://www.suntimes.com/news/watchdogs/757340,CST-NWS-watchdog24.article', '8 things you need to know about Obama, Rezko :: CHICAGO SUN-TIMES :: The Watchdogs', '', NULL, 0, '2008-08-01 19:12:48', 1, 158, 'related'),
(199, 'Obama was a student at Harvard Law School and got an unsolicited job offer from Rezko, then a low-income housing developer in Chicago. Obama turned it down.', 'http://www.suntimes.com/news/watchdogs/757340,CST-NWS-watchdog24.article', '8 things you need to know about Obama, Rezko :: CHICAGO SUN-TIMES :: The Watchdogs', '', NULL, 0, '2008-08-01 19:19:34', 1, 159, 'related'),
(200, 'Barack Obama, the junior U. S. Senator from Illinois, is the first ever Africanâ€“American to become the presumptive presidential nominee for a U. S. major political party.', 'http://www.biography.com/featured-biography/barack-obama/index.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:21:14', 1, 160, 'related'),
(201, 'Barack Hussein Obama was born Aug. 4, 1961, in Honolulu, Hawaii.', 'http://www.biography.com/featured-biography/barack-obama/index.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:22:39', 1, 135, 'related'),
(202, 'His father, Barack Obama, Sr., was born of Luo ethnicity in Nyanza Province, Kenya.', 'http://www.biography.com/featured-biography/barack-obama/index.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:23:54', 1, 161, 'related'),
(203, 'Although reared among Muslims, Obama, Sr., became an atheist at some point.', 'http://www.biography.com/featured-biography/barack-obama/index.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:24:49', 1, 162, 'related'),
(204, 'Obamaâ€™s mother, Ann Dunham, grew up in Wichita, Kansas.', 'http://www.biography.com/featured-biography/barack-obama/index.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:25:08', 1, 163, 'related'),
(205, 'Obamaâ€™s parents separated when he was two years old and later divorced. ', 'http://www.biography.com/featured-biography/barack-obama/index.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:26:11', 1, 138, 'related'),
(206, 'Obamaâ€™s father went to Harvard to pursue Ph. D. studies and then returned to Kenya.', 'http://www.biography.com/featured-biography/barack-obama/index.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:26:28', 1, 164, 'related'),
(207, 'Obama attended schools in Jakarta, where classes were taught in the Indonesian language.', 'http://www.biography.com/featured-biography/barack-obama/index.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:27:09', 1, 165, 'related'),
(208, 'commonly known throughout his early years as "Barry"', 'http://www.biography.com/featured-biography/barack-obama/index.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:27:49', 1, 166, 'related'),
(209, 'He saw his biological father (who died in a 1982 car accident) only once (in 1971) after his parents divorced.', 'http://www.biography.com/featured-biography/barack-obama/index.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:28:40', 1, 167, 'related'),
(210, 'he admitted using alcohol, marijuana and cocaine during his teenage years', 'http://www.biography.com/featured-biography/barack-obama/index.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:29:14', 1, 73, 'related'),
(211, 'He then transferred to Columbia University in New York, graduating in 1983 with a degree in political science.', 'http://www.biography.com/featured-biography/barack-obama/index.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:29:42', 1, 168, 'related'),
(212, 'There, he worked as a community organizer with low-income residents in Chicagoâ€™s Roseland community and the Altgeld Gardens public housing development on the cityâ€™s South Side.', 'http://www.biography.com/featured-biography/barack-obama/index.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:30:59', 1, 169, 'related'),
(213, 'In February 1990, he was elected the first Africanâ€“American editor of the Harvard Law Review', 'http://www.biography.com/featured-biography/barack-obama/bio2.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:31:41', 1, 170, 'related'),
(214, 'He also taught at the University of Chicago Law School.', 'http://www.biography.com/featured-biography/barack-obama/bio2.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:32:10', 1, 171, 'related'),
(215, 'Obama published an autobiography in 1995 Dreams From My Father: A Story of Race and Inheritance. And he won a Grammy for the audio version of the book.', 'http://www.biography.com/featured-biography/barack-obama/bio2.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:32:51', 1, 172, 'related'),
(216, 'He was elected in 1996 from the south side neighborhood of Hyde Park.', 'http://www.biography.com/featured-biography/barack-obama/bio2.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:33:39', 1, 173, 'related'),
(217, 'In 2000, Obama made an unsuccessful Democratic primary run for the U. S. House of Representatives seat held by four-term incumbent candidate Bobby Rush.', 'http://www.biography.com/featured-biography/barack-obama/bio2.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:34:24', 1, 174, 'related'),
(218, 'Following the 9/11 attacks, Obama was an early opponent of President George W. Bushâ€™s push to war with Iraq. Obama was still a state senator when he spoke against a resolution authorizing the use of force against Iraq during a rally at Chicagoâ€™s Federal Plaza in October 2002.', 'http://www.biography.com/featured-biography/barack-obama/bio2.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:34:49', 1, 175, 'related'),
(219, '"I know that even a successful war against Iraq will require a U. S. occupation of undetermined length, at undetermined cost, with undetermined consequences," ', 'http://www.biography.com/featured-biography/barack-obama/bio2.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:35:46', 1, 176, 'related'),
(220, 'The war with Iraq began in 2003 and Obama decided to run for the U.S. Senate open seat vacated by Republican Peter Fitzgerald. In the 2004 Democratic primary, he won 52 percent of the vote, defeating multimillionaire businessman Blair Hull and Illinois Comptroller Daniel Hynes.', 'http://www.biography.com/featured-biography/barack-obama/bio3.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:37:17', 1, 177, 'related'),
(221, 'That summer, he was invited to deliver the keynote speech in support of John Kerry at the 2004 Democratic National Convention in Boston.', 'http://www.biography.com/featured-biography/barack-obama/bio3.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:38:02', 1, 178, 'related'),
(222, 'In the November 2004 general election, Obama received 70% of the vote to Keyes''s 27%, the largest electoral victory in Illinois history', 'http://www.biography.com/featured-biography/barack-obama/bio3.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:40:11', 1, 179, 'related'),
(223, 'Obama became only the third African American elected to the U.S. Senate since Reconstruction.', 'http://www.biography.com/featured-biography/barack-obama/bio3.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:40:36', 1, 180, 'related'),
(224, 'Sworn into office January 4, 2005, Obama partnered with Republican Sen. Richard Lugar of Indiana on a bill that expanded efforts to destroy weapons of mass destruction in Eastern Europe and Russia. Then with Republican Sen. Tom Corburn of Oklahoma, he created a website that tracks all federal spending. ', 'http://www.biography.com/featured-biography/barack-obama/bio3.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:42:41', 1, 181, 'related'),
(225, 'Obama was also the first to raise the threat of avian flu on the Senate floor', 'http://www.biography.com/featured-biography/barack-obama/bio3.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:43:14', 1, 182, 'related'),
(226, 'live in Kenwood on Chicago''s South Side', 'http://www.biography.com/featured-biography/barack-obama/bio3.jsp', 'Barack Obama Featured Biography', '', NULL, 0, '2008-08-01 19:44:09', 1, 183, 'related'),
(227, 'When television''s Inside Edition ran a segment on this issue, they included some images (supplied by the Obama campaign) of the senator standing with his hand over his heart during other playings of the national anthem: ', 'http://www.snopes.com/politics/obama/anthem.asp', 'snopes.com: Barack Obama and the National Anthem', '', NULL, 0, '2008-08-01 19:47:17', 1, 184, 'related'),
(228, 'he following video clips show Barack Obama reciting the Pledge during the opening of Senate sessions', 'http://www.snopes.com/politics/obama/anthem.asp', 'snopes.com: Barack Obama and the National Anthem', '', NULL, 0, '2008-08-01 19:48:02', 1, 185, 'related'),
(229, 'Senator Obama directly refuted the three primary rumors about him that are circulating via e-mail: that he is a Muslim, that he was sworn in to Congress on the Quran, and that he refuses to say the Pledge of Allegiance', 'http://www.snopes.com/politics/obama/anthem.asp', 'snopes.com: Barack Obama and the National Anthem', '', NULL, 0, '2008-08-01 19:48:22', 1, 185, 'related'),
(230, 'Senator Obama directly refuted the three primary rumors about him that are circulating via e-mail: that he is a Muslim, that he was sworn in to Congress on the Quran, and that he refuses to say the Pledge of Allegiance: ', 'http://www.snopes.com/politics/obama/anthem.asp', 'snopes.com: Barack Obama and the National Anthem', '', NULL, 0, '2008-08-01 19:48:35', 1, 133, 'related'),
(231, 'Senator Obama directly refuted the three primary rumors about him that are circulating via e-mail: that he is a Muslim, that he was sworn in to Congress on the Quran, and that he refuses to say the Pledge of Allegiance:', 'http://www.snopes.com/politics/obama/anthem.asp', 'snopes.com: Barack Obama and the National Anthem', '', NULL, 0, '2008-08-01 19:49:02', 1, 186, 'related'),
(232, ' During the Democratic candidates'' debate on 15 January 2008, Senator Obama directly refuted the three primary rumors about him that are circulating via e-mail: that he is a Muslim, that he was sworn in to Congress on the Quran, and that he refuses to say the Pledge of Allegiance:', 'http://www.snopes.com/politics/obama/anthem.asp', 'snopes.com: Barack Obama and the National Anthem', '', NULL, 0, '2008-08-01 19:50:18', 1, 187, 'related'),
(233, 'Democratic presidential candidate Barack Obama said on Friday he would back limited offshore drilling as part of a broader energy package that attempted to bring down gas prices and reduce U.S. dependence on foreign oil.', 'http://www.reuters.com/article/vcCandidateFeed2/idUSN0140632620080802', 'Obama says would consider limited offshore drilling | Reuters', '', NULL, 0, '2008-08-01 19:51:25', 1, 188, 'related'),
(234, 'In a statement, Obama said he remained skeptical of the value of expanded offshore drilling in fighting rising gas prices. He has said he prefers oil companies to use the land already available.', 'http://www.reuters.com/article/vcCandidateFeed2/idUSN0140632620080802', 'Obama says would consider limited offshore drilling | Reuters', '', NULL, 0, '2008-08-01 19:52:14', 1, 189, 'related'),
(235, 'Obama dropped his blanket opposition to any expansion of offshore drilling and signaled support for a bipartisan compromise in Congress aimed at breaking a deadlock on energy that includes limited drilling.', 'http://www.reuters.com/article/vcCandidateFeed2/idUSN0140632620080802', 'Obama says would consider limited offshore drilling | Reuters', '', NULL, 0, '2008-08-01 19:52:31', 1, 190, 'related'),
(236, 'The Federal Highway Administration reported in 2006 that one quarter of the nation''s bridges were at risk. The American Society for Civil Engineers said in 2006 that it would cost nearly $10 billion every year for the next two decades to fix them.', 'http://www.cnn.com/2008/US/08/01/kaye.crumbling.infrastructure/index.html', 'Nation''s bridges, roads still ''structurally deficient'' - CNN.com', '', NULL, 0, '2008-08-01 19:55:28', 1, 192, 'related'),
(237, 'But the funds used to repair and maintain the country''s bridges and highways are drying up. Some of the money comes from the Highway Trust Fund, which Americans pay for through taxes on gasoline. Faced with higher gas prices, more commuters are carpooling, taking mass transit or driving less, about 4 percent less in May alone compared with a year ago', 'http://www.cnn.com/2008/US/08/01/kaye.crumbling.infrastructure/index.html', 'Nation''s bridges, roads still ''structurally deficient'' - CNN.com', '', NULL, 0, '2008-08-01 19:56:31', 1, 193, 'related'),
(238, 'nearly every state is facing a budget crisis and doesn''t have the money to solve problems.', 'http://www.cnn.com/2008/US/08/01/kaye.crumbling.infrastructure/index.html', 'Nation''s bridges, roads still ''structurally deficient'' - CNN.com', '', NULL, 0, '2008-08-01 19:56:54', 1, 194, 'related'),
(239, 'Even after the Minneapolis bridge collapse, not all the bridges in the state are structurally safe. In fact, on July 26, chunks of concrete weighing about 1,200 pounds fell from an overpass in St. Paul, just a few miles from the Minneapolis scene.', 'http://www.cnn.com/2008/US/08/01/kaye.crumbling.infrastructure/index.html', 'Nation''s bridges, roads still ''structurally deficient'' - CNN.com', '', NULL, 0, '2008-08-01 19:58:03', 1, 195, 'related'),
(240, 'Signs of vast quantities of underground ice in the polar regions were first spotted from orbit by the Mars Odyssey spacecraft in 2002.', 'http://www.nytimes.com/2008/08/01/science/space/01mars.html', 'Test of Mars Soil Sample Confirms Presence of Ice - NYTimes.com', '', NULL, 0, '2008-08-01 20:02:00', 1, 196, 'related'),
(241, 'Heated to 32 degrees Fahrenheit, a sample of soil being analyzed by NASAâ€™s Phoenix Mars lander let out a puff of vapor, providing final confirmation that the lander is sitting over a large chunk of ice.', 'http://www.nytimes.com/2008/08/01/science/space/01mars.html', 'Test of Mars Soil Sample Confirms Presence of Ice - NYTimes.com', '', NULL, 0, '2008-08-01 20:02:25', 1, 197, 'related'),
(242, 'Weatherman, known colloquially as the Weathermen and later the Weather Underground Organization', 'http://en.wikipedia.org/wiki/Weatherman_(organization)', 'Weatherman (organization) - Wikipedia, the free encyclopedia', '', NULL, 0, '2008-08-01 20:06:16', 1, 198, 'related'),
(243, 'The group, which organized a riot in Chicago in 1969 and bombed buildings in the 1970s, was founded in 1969 by leaders and members who split from the Students for a Democratic Society (SDS).', 'http://en.wikipedia.org/w/index.php?oldid=227185368', 'Weatherman (organization) - Wikipedia, the free encyclopedia', '', NULL, 0, '2008-08-01 20:06:46', 1, 199, 'related'),
(244, 'Their founding document called for the establishment of a "white fighting force" to be allied with the "Black Liberation Movement" and other "anti-colonial" movements[1] to achieve "the destruction of US imperialism and the achievement of a classless world: world communism."[2]', 'http://en.wikipedia.org/wiki/Weatherman_(organization)', 'Weatherman (organization) - Wikipedia, the free encyclopedia', '', NULL, 0, '2008-08-01 20:07:59', 1, 200, 'related'),
(245, 'Their attacks were mostly bombings of government buildings, along with several banks, police department headquarters and precincts, state and federal courthouses, and state prison administrative offices', 'http://en.wikipedia.org/w/index.php?oldid=227185368', 'Weatherman (organization) - Wikipedia, the free encyclopedia', '', NULL, 0, '2008-08-01 20:08:55', 1, 201, 'related'),
(246, 'Apart from an apparently accidental premature detonation of a bomb in the Greenwich Village townhouse explosion which claimed the lives of three of their own members, no one was ever harmed in their extensive bombing campaign, as they were always careful to issue warnings in advance to ensure a safe evacuation of the area prior to detonation.', 'http://en.wikipedia.org/w/index.php?oldid=227185368', 'Weatherman (organization) - Wikipedia, the free encyclopedia', '', NULL, 0, '2008-08-01 20:10:27', 1, 202, 'related');

-- --------------------------------------------------------

-- 
-- Table structure for table `sources`
-- 

CREATE TABLE `sources` (
  `id` int(11) NOT NULL auto_increment,
  `domain` varchar(64) NOT NULL,
  `hostexp` varchar(64) NOT NULL,
  `name` varchar(64) NOT NULL,
  `sourceexp` varchar(64) NOT NULL,
  `subjectexp` varchar(64) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `domain` (`domain`,`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- 
-- Dumping data for table `sources`
-- 

INSERT INTO `sources` (`id`, `domain`, `hostexp`, `name`, `sourceexp`, `subjectexp`) VALUES 
(1, 'reuters.com', '', 'Reuters', '', '(.*) \\|'),
(2, 'foxnews.com', '', 'Fox News', '', '.* - ([^-]*)'),
(3, 'bbc.co.uk', '', 'BBC News', '', '\\| ([^|]*)$'),
(0, '', '', '', '', '');

-- --------------------------------------------------------

-- 
-- Table structure for table `topic_links`
-- 

CREATE TABLE `topic_links` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `parent_id` int(11) unsigned NOT NULL,
  `child_id` int(11) unsigned NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `parent_id` (`parent_id`,`child_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `topic_links`
-- 

INSERT INTO `topic_links` (`id`, `parent_id`, `child_id`, `user_id`) VALUES 
(1, 2, 4, 8);

-- --------------------------------------------------------

-- 
-- Table structure for table `topics`
-- 

CREATE TABLE `topics` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `txt` varchar(128) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`),
  KEY `txt` (`txt`),
  FULLTEXT KEY `text` (`txt`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

-- 
-- Dumping data for table `topics`
-- 

INSERT INTO `topics` (`id`, `txt`, `user_id`, `created_at`) VALUES 
(1, 'test topic 2', 8, '2008-07-28 17:22:20'),
(2, 'test topic 1', 8, '2008-07-28 17:25:45'),
(3, 'Presidential election 2008', 8, '2008-07-28 17:27:21'),
(4, 'test topic 3', 8, '2008-07-29 18:22:18'),
(5, '2008 Los Angeles earthquake ', 1, '2008-08-01 17:21:03'),
(6, 'Barack Obama', 1, '2008-08-01 18:04:08'),
(7, 'John McCain', 1, '2008-08-01 18:27:03'),
(8, 'Hilary Clinton', 1, '2008-08-01 18:33:36'),
(9, 'The Weather Underground', 1, '2008-08-01 18:41:29'),
(10, 'William Ayers', 1, '2008-08-01 18:44:14'),
(11, 'Bernadine Dhorn', 1, '2008-08-01 18:44:42'),
(12, 'Nazi Death Camps', 1, '2008-08-01 19:02:11'),
(13, 'Tony Rezko', 1, '2008-08-01 19:12:58'),
(14, 'Relationship between Barack Obama and Tony Rezko', 1, '2008-08-01 19:20:10'),
(15, 'Columbia University', 1, '2008-08-01 19:30:02'),
(16, 'Obama and the Iraq War', 1, '2008-08-01 19:36:23'),
(17, 'Chicago South Side', 1, '2008-08-01 19:44:24'),
(18, 'Mars', 1, '2008-08-01 20:02:54'),
(19, 'Water Ice on Mars', 1, '2008-08-01 20:03:06');

-- --------------------------------------------------------

-- 
-- Table structure for table `users`
-- 

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(128) NOT NULL,
  `name` varchar(64) NOT NULL,
  `password` varchar(16) NOT NULL,
  `secret` varchar(16) NOT NULL,
  `status` enum('active','pending','banned') NOT NULL,
  `created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  `facebookid` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `secret` (`secret`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

-- 
-- Dumping data for table `users`
-- 

INSERT INTO `users` (`id`, `email`, `name`, `password`, `secret`, `status`, `created_at`, `facebookid`) VALUES 
(1, 'rob@ennals.org', 'rob', 'password', 'HneGhDrJVP', 'active', '2008-06-18 15:37:10', 0),
(2, 'rob@ennals.org', 'rob2', 'pass', 'K8BHWiP5te', 'pending', '2008-06-18 15:41:29', 0),
(3, 'rob.ennals@gmail.com', 'rob3', 'pass', '24EM3TC2PX', 'pending', '2008-06-18 15:42:40', 0),
(4, 'rob.ennals@gmail.com', 'rob4', 'test', 'gfUJdWCqX2', 'pending', '2008-06-18 17:24:54', 0),
(5, 'rob.ennals@gmail.com', 'rob5', 'test', '3JV7XbmJ7t', 'pending', '2008-06-18 17:25:19', 0),
(6, 'rob.ennals@gmail.com', 'rob6', 'bla', 'u6d9tcTtdp', 'pending', '2008-06-18 17:42:09', 0),
(7, 'rob.ennals@gmail.com', 'rob7', 'foo', 'rFfujVmtxU', 'active', '2008-06-18 18:23:27', 0),
(8, 'trush@eecs.berkeley.edu', 'Beth', 'think', 'KYkN6h7uNW', 'active', '2008-06-19 13:42:05', 0);
