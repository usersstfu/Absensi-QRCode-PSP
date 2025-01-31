-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jan 31, 2025 at 12:11 AM
-- Server version: 10.11.10-MariaDB
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u146793798_absensi_psp`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendances`
--

CREATE TABLE `attendances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` char(26) NOT NULL,
  `barcode_id` bigint(20) UNSIGNED DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time_in` time DEFAULT NULL,
  `time_out` time DEFAULT NULL,
  `shift_id` bigint(20) UNSIGNED DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `status` enum('present','late','excused','sick','absent','dinas','request') NOT NULL DEFAULT 'absent',
  `is_late` tinyint(1) NOT NULL DEFAULT 0,
  `approval_status` varchar(255) DEFAULT NULL,
  `request_note` text DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `attachment` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attendances`
--

INSERT INTO `attendances` (`id`, `user_id`, `barcode_id`, `date`, `time_in`, `time_out`, `shift_id`, `latitude`, `longitude`, `status`, `is_late`, `approval_status`, `request_note`, `note`, `attachment`, `created_at`, `updated_at`, `deleted_at`) VALUES
(41, '01jf9drn1vvv57nrwmraqbshc2', 2, '2025-01-06', '07:12:48', '15:01:16', 3, -2.186924, 113.8967178, 'late', 0, NULL, NULL, NULL, NULL, '2025-01-06 07:12:48', '2025-01-06 15:01:16', NULL),
(42, '01jgnef77aytmaj08sq2z9m2hf', 2, '2025-01-06', '07:16:26', '15:02:03', 3, -2.1869264269161, 113.89670075121, 'late', 0, NULL, NULL, NULL, NULL, '2025-01-06 07:16:26', '2025-01-06 15:02:03', NULL),
(43, '01jgng7hvw40kpt6fgvqn2w604', 4, '2025-01-06', '08:52:42', NULL, 4, -0.51572, 117.1164422, 'late', 0, NULL, NULL, NULL, NULL, '2025-01-06 07:52:42', '2025-01-06 07:52:42', NULL),
(44, '01jgnmc8svsvhjth2efcq786tw', 5, '2025-01-06', '08:57:30', NULL, 5, -6.1736242, 106.6875907, 'late', 0, NULL, NULL, NULL, NULL, '2025-01-06 08:57:30', '2025-01-06 08:57:30', NULL),
(55, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-06', '10:30:49', '14:01:42', 4, -0.51566075129512, 117.11650045015, 'late', 0, NULL, NULL, NULL, NULL, '2025-01-06 09:30:49', '2025-01-06 14:01:42', NULL),
(56, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-07', '06:36:08', '14:00:07', 4, -0.51564344046125, 117.11627871779, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-07 05:36:08', '2025-01-07 14:00:07', NULL),
(57, '01jgng7hvw40kpt6fgvqn2w604', 4, '2025-01-07', '06:54:52', NULL, 4, -0.515678, 117.1164528, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-07 05:54:52', '2025-01-07 05:54:52', NULL),
(60, '01jgnmc8svsvhjth2efcq786tw', 5, '2025-01-07', '08:30:10', '17:03:56', 5, -6.1737361, 106.6872281, 'late', 0, NULL, NULL, NULL, NULL, '2025-01-07 08:30:10', '2025-01-07 17:03:56', NULL),
(62, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-08', '06:46:41', '14:00:28', 4, -0.51563596786751, 117.11627462027, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-08 05:46:41', '2025-01-08 14:00:28', NULL),
(63, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-08', NULL, NULL, NULL, -0.503107, 117.1093885, 'excused', 0, 'pending', NULL, 'Izin', NULL, '2025-01-08 06:14:08', '2025-01-08 06:14:08', NULL),
(64, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-09', NULL, NULL, NULL, -0.503107, 117.1093885, 'excused', 0, 'approved', NULL, 'Izin', NULL, '2025-01-08 06:14:08', '2025-01-09 07:47:35', NULL),
(65, '01jgnef77aytmaj08sq2z9m2hf', 2, '2025-01-08', '06:49:24', '15:01:34', 3, -2.1869234906151, 113.89670093121, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-08 06:49:24', '2025-01-08 15:01:34', NULL),
(66, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-08', NULL, NULL, NULL, -2.1869241, 113.8967049, 'excused', 0, 'approved', NULL, 'Testing', NULL, '2025-01-08 06:54:21', '2025-01-08 06:55:24', NULL),
(71, '01jgnmc8svsvhjth2efcq786tw', 5, '2025-01-08', '08:40:46', '17:02:13', 5, -6.1736305, 106.6875957, 'late', 0, NULL, NULL, NULL, NULL, '2025-01-08 08:40:46', '2025-01-08 17:02:13', NULL),
(76, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-09', '06:42:30', '14:00:50', 4, -0.51566099906951, 117.11649984153, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-09 05:42:30', '2025-01-09 14:00:50', NULL),
(82, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-09', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Automatically marked as absent.', NULL, '2025-01-09 23:59:03', '2025-01-09 23:59:03', NULL),
(83, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-09', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Automatically marked as absent.', NULL, '2025-01-09 23:59:03', '2025-01-09 23:59:03', NULL),
(84, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-09', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Automatically marked as absent.', NULL, '2025-01-09 23:59:03', '2025-01-09 23:59:03', NULL),
(85, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-10', '06:46:25', '14:00:36', 4, -0.51556339055786, 117.11631912001, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-10 05:46:25', '2025-01-10 14:00:36', NULL),
(91, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-10', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-10 23:59:03', '2025-01-10 23:59:03', NULL),
(92, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-10', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-10 23:59:03', '2025-01-10 23:59:03', NULL),
(93, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-10', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-10 23:59:03', '2025-01-10 23:59:03', NULL),
(94, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-10', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-10 23:59:03', '2025-01-10 23:59:03', NULL),
(95, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-11', '06:38:49', '12:00:39', 4, -0.51563361133088, 117.11660452397, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-11 05:38:49', '2025-01-11 12:00:39', NULL),
(96, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-11', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-11 23:59:03', '2025-01-11 23:59:03', NULL),
(97, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-13', '06:36:27', '14:00:07', 4, -0.51565652230667, 117.11649747557, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-13 05:36:27', '2025-01-13 14:00:07', NULL),
(101, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-14', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-14 07:11:24', '2025-01-14 07:11:24', NULL),
(102, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-14', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-14 07:11:24', '2025-01-14 07:11:24', NULL),
(103, '01jgngax934sy0bqggkbgp6j68', NULL, '2025-01-14', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-14 07:11:24', '2025-01-14 07:11:24', NULL),
(104, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-14', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-14 07:11:24', '2025-01-14 07:11:24', NULL),
(106, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-14', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-14 23:59:03', '2025-01-14 23:59:03', NULL),
(124, '01jgng7hvw40kpt6fgvqn2w604', 4, '2025-01-15', '11:27:03', NULL, 4, -0.5157264, 117.1164396, 'late', 0, NULL, NULL, NULL, NULL, '2025-01-15 10:27:03', '2025-01-15 10:27:03', NULL),
(127, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-15', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-15 23:59:03', '2025-01-15 23:59:03', NULL),
(128, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-15', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-15 23:59:03', '2025-01-15 23:59:03', NULL),
(129, '01jgngax934sy0bqggkbgp6j68', NULL, '2025-01-15', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-15 23:59:03', '2025-01-15 23:59:03', NULL),
(130, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-15', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-15 23:59:03', '2025-01-15 23:59:03', NULL),
(131, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-16', '06:46:43', '14:00:03', 4, -0.51565699165281, 117.11649596281, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-16 05:46:43', '2025-01-16 14:00:03', NULL),
(132, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-16', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-16 23:59:03', '2025-01-16 23:59:03', NULL),
(133, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-16', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-16 23:59:03', '2025-01-16 23:59:03', NULL),
(134, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-16', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-16 23:59:03', '2025-01-16 23:59:03', NULL),
(135, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-16', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-16 23:59:03', '2025-01-16 23:59:03', NULL),
(136, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-17', '06:34:34', NULL, 4, -0.51563741496277, 117.11647880317, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-17 05:34:34', '2025-01-17 05:34:34', NULL),
(151, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-17', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-17 23:59:03', '2025-01-17 23:59:03', NULL),
(152, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-17', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-17 23:59:03', '2025-01-17 23:59:03', NULL),
(153, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-17', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-17 23:59:03', '2025-01-17 23:59:03', NULL),
(154, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-17', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-17 23:59:03', '2025-01-17 23:59:03', NULL),
(155, '01jhsh1b7qxgnbgbjp2mtejvmr', NULL, '2025-01-17', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-17 23:59:03', '2025-01-17 23:59:03', NULL),
(156, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-18', '06:38:32', NULL, 4, -0.51566570806583, 117.11648161603, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-18 05:38:32', '2025-01-18 05:38:32', NULL),
(157, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-18', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-18 23:59:04', '2025-01-18 23:59:04', NULL),
(158, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-20', '06:40:55', '14:00:20', 4, -0.51566475541554, 117.11647222404, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-20 05:40:55', '2025-01-20 14:00:20', NULL),
(159, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-20', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-20 23:59:03', '2025-01-20 23:59:03', NULL),
(160, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-20', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-20 23:59:03', '2025-01-20 23:59:03', NULL),
(161, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-20', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-20 23:59:03', '2025-01-20 23:59:03', NULL),
(162, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-20', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-20 23:59:03', '2025-01-20 23:59:03', NULL),
(163, '01jhsh1b7qxgnbgbjp2mtejvmr', NULL, '2025-01-20', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-20 23:59:03', '2025-01-20 23:59:03', NULL),
(164, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-21', '06:40:13', '14:00:11', 4, -0.51565699165281, 117.11649596281, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-21 05:40:13', '2025-01-21 14:00:11', NULL),
(165, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-21', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-21 23:59:03', '2025-01-21 23:59:03', NULL),
(166, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-21', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-21 23:59:03', '2025-01-21 23:59:03', NULL),
(167, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-21', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-21 23:59:03', '2025-01-21 23:59:03', NULL),
(168, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-21', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-21 23:59:03', '2025-01-21 23:59:03', NULL),
(169, '01jhsh1b7qxgnbgbjp2mtejvmr', NULL, '2025-01-21', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-21 23:59:03', '2025-01-21 23:59:03', NULL),
(170, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-22', '06:44:08', '14:00:16', 4, -0.51564638452941, 117.11650761437, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-22 05:44:08', '2025-01-22 14:00:16', NULL),
(173, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-22', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-22 23:59:03', '2025-01-22 23:59:03', NULL),
(174, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-22', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-22 23:59:03', '2025-01-22 23:59:03', NULL),
(175, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-22', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-22 23:59:03', '2025-01-22 23:59:03', NULL),
(176, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-22', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-22 23:59:03', '2025-01-22 23:59:03', NULL),
(177, '01jhsh1b7qxgnbgbjp2mtejvmr', NULL, '2025-01-22', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-22 23:59:03', '2025-01-22 23:59:03', NULL),
(178, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-23', '06:44:08', '14:00:05', 4, -0.51565699165281, 117.11649596281, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-23 05:44:08', '2025-01-23 14:00:05', NULL),
(179, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-23', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-23 23:59:03', '2025-01-23 23:59:03', NULL),
(180, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-23', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-23 23:59:03', '2025-01-23 23:59:03', NULL),
(181, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-23', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-23 23:59:03', '2025-01-23 23:59:03', NULL),
(182, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-23', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-23 23:59:03', '2025-01-23 23:59:03', NULL),
(183, '01jhsh1b7qxgnbgbjp2mtejvmr', NULL, '2025-01-23', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-23 23:59:03', '2025-01-23 23:59:03', NULL),
(184, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-24', '06:48:42', '14:00:26', 4, -0.51562080914153, 117.11638881197, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-24 05:48:42', '2025-01-24 14:00:26', NULL),
(185, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-24', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-24 23:59:03', '2025-01-24 23:59:03', NULL),
(186, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-24', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-24 23:59:03', '2025-01-24 23:59:03', NULL),
(187, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-24', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-24 23:59:03', '2025-01-24 23:59:03', NULL),
(188, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-24', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-24 23:59:03', '2025-01-24 23:59:03', NULL),
(189, '01jhsh1b7qxgnbgbjp2mtejvmr', NULL, '2025-01-24', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-24 23:59:03', '2025-01-24 23:59:03', NULL),
(190, '01jgngax934sy0bqggkbgp6j68', 4, '2025-01-25', '06:37:31', NULL, 4, -0.51557611449786, 117.11641773039, 'present', 0, NULL, NULL, NULL, NULL, '2025-01-25 05:37:31', '2025-01-25 05:37:31', NULL),
(191, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-25', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-25 23:59:04', '2025-01-25 23:59:04', NULL),
(192, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-27', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-27 23:59:03', '2025-01-27 23:59:03', NULL),
(193, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-27', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-27 23:59:03', '2025-01-27 23:59:03', NULL),
(194, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-27', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-27 23:59:03', '2025-01-27 23:59:03', NULL),
(195, '01jgngax934sy0bqggkbgp6j68', NULL, '2025-01-27', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-27 23:59:03', '2025-01-27 23:59:03', NULL),
(196, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-27', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-27 23:59:03', '2025-01-27 23:59:03', NULL),
(197, '01jhsh1b7qxgnbgbjp2mtejvmr', NULL, '2025-01-27', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-27 23:59:03', '2025-01-27 23:59:03', NULL),
(198, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-28', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-28 23:59:03', '2025-01-28 23:59:03', NULL),
(199, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-28', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-28 23:59:03', '2025-01-28 23:59:03', NULL),
(200, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-28', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-28 23:59:03', '2025-01-28 23:59:03', NULL),
(201, '01jgngax934sy0bqggkbgp6j68', NULL, '2025-01-28', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-28 23:59:03', '2025-01-28 23:59:03', NULL),
(202, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-28', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-28 23:59:03', '2025-01-28 23:59:03', NULL),
(203, '01jhsh1b7qxgnbgbjp2mtejvmr', NULL, '2025-01-28', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-28 23:59:03', '2025-01-28 23:59:03', NULL),
(204, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-29', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-29 23:59:03', '2025-01-29 23:59:03', NULL),
(205, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-29', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-29 23:59:03', '2025-01-29 23:59:03', NULL),
(206, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-29', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-29 23:59:03', '2025-01-29 23:59:03', NULL),
(207, '01jgngax934sy0bqggkbgp6j68', NULL, '2025-01-29', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-29 23:59:03', '2025-01-29 23:59:03', NULL),
(208, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-29', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-29 23:59:03', '2025-01-29 23:59:03', NULL),
(209, '01jhsh1b7qxgnbgbjp2mtejvmr', NULL, '2025-01-29', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-29 23:59:03', '2025-01-29 23:59:03', NULL),
(210, '01jf9drn1vvv57nrwmraqbshc2', NULL, '2025-01-30', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-30 23:59:03', '2025-01-30 23:59:03', NULL),
(211, '01jgnef77aytmaj08sq2z9m2hf', NULL, '2025-01-30', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-30 23:59:03', '2025-01-30 23:59:03', NULL),
(212, '01jgng7hvw40kpt6fgvqn2w604', NULL, '2025-01-30', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-30 23:59:03', '2025-01-30 23:59:03', NULL),
(213, '01jgngax934sy0bqggkbgp6j68', NULL, '2025-01-30', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-30 23:59:03', '2025-01-30 23:59:03', NULL),
(214, '01jgnmc8svsvhjth2efcq786tw', NULL, '2025-01-30', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-30 23:59:03', '2025-01-30 23:59:03', NULL),
(215, '01jhsh1b7qxgnbgbjp2mtejvmr', NULL, '2025-01-30', NULL, NULL, NULL, NULL, NULL, 'absent', 0, NULL, NULL, 'Tidak Hadir Untuk Hari Ini', NULL, '2025-01-30 23:59:03', '2025-01-30 23:59:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `barcodes`
--

CREATE TABLE `barcodes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` varchar(255) NOT NULL,
  `latitude` double NOT NULL DEFAULT 0,
  `longitude` double NOT NULL DEFAULT 0,
  `radius` double NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `division_id` bigint(20) UNSIGNED DEFAULT NULL,
  `shift_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `barcodes`
--

INSERT INTO `barcodes` (`id`, `name`, `value`, `latitude`, `longitude`, `radius`, `created_at`, `updated_at`, `division_id`, `shift_id`) VALUES
(2, 'Outlet Palangka Raya', '5541379637474', -2.1869121784468, 113.89671464105, 50, '2024-12-17 04:41:27', '2025-01-13 12:55:18', 1, 3),
(4, 'Outlet Kalimantan Timur', '5402297487717', -0.5156477221138, 117.11630308889, 50, '2025-01-05 20:07:19', '2025-01-13 12:55:26', 2, 4),
(5, 'HO Jakarta', '3859984528868', -6.1736236526468, 106.68760558009, 50, '2025-01-05 20:14:50', '2025-01-13 12:55:35', 3, 5),
(6, 'Simling POLDA CFD', '4816912277994', -2.2075553634825, 113.91528562785, 50, '2025-01-13 14:24:31', '2025-01-13 14:24:31', 1, 6);

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('31934a89f38795aa826ab2292a5fa6ea', 'i:1;', 1737499493),
('31934a89f38795aa826ab2292a5fa6ea:timer', 'i:1737499493;', 1737499493),
('41f0e5d4e038cb3eed847a1f5d87020c', 'i:1;', 1737331456),
('41f0e5d4e038cb3eed847a1f5d87020c:timer', 'i:1737331456;', 1737331456),
('68984196b750b0c1891ab997e64b6f1e', 'i:1;', 1737372268),
('68984196b750b0c1891ab997e64b6f1e:timer', 'i:1737372268;', 1737372268),
('6b5b4c1a58df5ff7c675c820196d35b8', 'i:1;', 1738069053),
('6b5b4c1a58df5ff7c675c820196d35b8:timer', 'i:1738069053;', 1738069053),
('6b6639a0eeb6b50fb9a5dbbd1440360e', 'i:1;', 1738195390),
('6b6639a0eeb6b50fb9a5dbbd1440360e:timer', 'i:1738195390;', 1738195390),
('7af972c43ca0c0776b3d47d4bc15d30e', 'i:1;', 1738191758),
('7af972c43ca0c0776b3d47d4bc15d30e:timer', 'i:1738191758;', 1738191758),
('7ebef49b743567b6f5295537c2011755', 'i:1;', 1738281805),
('7ebef49b743567b6f5295537c2011755:timer', 'i:1738281805;', 1738281805),
('838dffd3f20259865c83be0883c278bc', 'i:1;', 1737098629),
('838dffd3f20259865c83be0883c278bc:timer', 'i:1737098629;', 1737098629),
('86e9b491c46b05b773df18e7597a2c69', 'i:1;', 1737506247),
('86e9b491c46b05b773df18e7597a2c69:timer', 'i:1737506247;', 1737506247),
('9a7e29456289e3aad603945bdfbe396a', 'i:1;', 1737176293),
('9a7e29456289e3aad603945bdfbe396a:timer', 'i:1737176293;', 1737176293),
('9e32aeeb24dd9a1ec49557232e100ba3', 'i:2;', 1737098019),
('9e32aeeb24dd9a1ec49557232e100ba3:timer', 'i:1737098019;', 1737098019),
('afff6dbfeeb33b606a7fa41c3f637992', 'i:1;', 1737339007),
('afff6dbfeeb33b606a7fa41c3f637992:timer', 'i:1737339007;', 1737339007),
('attendance-01jhsh1b7qxgnbgbjp2mtejvmr-1-2025', 'a:3:{i:0;a:10:{s:2:\"id\";i:155;s:6:\"status\";s:6:\"absent\";s:4:\"date\";s:10:\"2025-01-17\";s:8:\"latitude\";N;s:9:\"longitude\";N;s:10:\"attachment\";N;s:4:\"note\";s:26:\"Tidak Hadir Untuk Hari Ini\";s:11:\"coordinates\";N;s:3:\"lat\";N;s:3:\"lng\";N;}i:1;a:10:{s:2:\"id\";i:163;s:6:\"status\";s:6:\"absent\";s:4:\"date\";s:10:\"2025-01-20\";s:8:\"latitude\";N;s:9:\"longitude\";N;s:10:\"attachment\";N;s:4:\"note\";s:26:\"Tidak Hadir Untuk Hari Ini\";s:11:\"coordinates\";N;s:3:\"lat\";N;s:3:\"lng\";N;}i:2;a:10:{s:2:\"id\";i:169;s:6:\"status\";s:6:\"absent\";s:4:\"date\";s:10:\"2025-01-21\";s:8:\"latitude\";N;s:9:\"longitude\";N;s:10:\"attachment\";N;s:4:\"note\";s:26:\"Tidak Hadir Untuk Hari Ini\";s:11:\"coordinates\";N;s:3:\"lat\";N;s:3:\"lng\";N;}}', 1737590529),
('c72b4482bce73acd5455c6b6b275cdb4', 'i:1;', 1737590481),
('c72b4482bce73acd5455c6b6b275cdb4:timer', 'i:1737590481;', 1737590481),
('cb92d73458502718e33bd42ee2ab7ad1', 'i:1;', 1738069041),
('cb92d73458502718e33bd42ee2ab7ad1:timer', 'i:1738069041;', 1738069041),
('dd5d53d6da5ade36b92c83ac93f22774', 'i:2;', 1737338952),
('dd5d53d6da5ade36b92c83ac93f22774:timer', 'i:1737338952;', 1737338952),
('de43f29331f6bb6328f4708aae3ba665', 'i:1;', 1737098379),
('de43f29331f6bb6328f4708aae3ba665:timer', 'i:1737098379;', 1737098379),
('df734d931c13f1f860d59d4042d58a4b', 'i:1;', 1738191734),
('df734d931c13f1f860d59d4042d58a4b:timer', 'i:1738191734;', 1738191734),
('ef7614f9db7f31eccdd6dc037ca86cf2', 'i:1;', 1738069081),
('ef7614f9db7f31eccdd6dc037ca86cf2:timer', 'i:1738069081;', 1738069081),
('fea10bfe87b42cf36139f98763b3e795', 'i:1;', 1737417997),
('fea10bfe87b42cf36139f98763b3e795:timer', 'i:1737417997;', 1737417997),
('fortify.2fa_codes.06456e71413bbc57e27b0a5730ff94dc', 'i:57922417;', 1737672634),
('fortify.2fa_codes.21977ae1a823ce27fafd61d07270f411', 'i:57905880;', 1737176543),
('fortify.2fa_codes.2f83404c6d4d41d7372abeb24310fa83', 'i:57939723;', 1738191818),
('fortify.2fa_codes.5bef549721500bc3a545adfdff9827e5', 'i:57920518;', 1737615678),
('fortify.2fa_codes.6efd116c0647d5a648ce7bf7d8430029', 'i:57910881;', 1737326565),
('fortify.2fa_codes.70b6fb907d654d519f9259a865a53c7f', 'i:57926039;', 1737781308),
('fortify.2fa_codes.a55b5ce83a666ee4dc2c988dc7366b5f', 'i:57919527;', 1737585957),
('fortify.2fa_codes.a652bf5ac9d913f9f4dd2face2c22137', 'i:57917639;', 1737529311),
('fortify.2fa_codes.ab5e390598ca417eff7ddda0d2a07b9e', 'i:57923400;', 1737702142),
('fortify.2fa_codes.b01b6acd593403450735da0c38655116', 'i:57913760;', 1737412925),
('fortify.2fa_codes.c07b8bf4020b7cbd4a548ba87bae1507', 'i:57911298;', 1737339067),
('fortify.2fa_codes.c662f2206b3fa3355a761ebb978107de', 'i:57905116;', 1737153625),
('fortify.2fa_codes.c7f5a1699ff48a816dd39287c7bbd443', 'i:57914760;', 1737442925),
('fortify.2fa_codes.df784a18439445c81100bdb12af014e1', 'i:57916647;', 1737499559),
('fortify.2fa_codes.e1093021a07f0a254e81b199b17f7da7', 'i:57925274;', 1737758364),
('fortify.2fa_codes.e692196821c04c67842308f368951fe4', 'i:57911880;', 1737356524),
('moloruth8@gmail.com|103.121.101.157', 'i:1;', 1737338952),
('moloruth8@gmail.com|103.121.101.157:timer', 'i:1737338952;', 1737338952),
('superadmin@gmail.com|180.241.185.133', 'i:2;', 1737098019),
('superadmin@gmail.com|180.241.185.133:timer', 'i:1737098019;', 1737098019),
('superadmin@gmail.com|182.4.39.115', 'i:1;', 1738069041),
('superadmin@gmail.com|182.4.39.115:timer', 'i:1738069041;', 1738069041);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `divisions`
--

CREATE TABLE `divisions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `timezone` varchar(255) NOT NULL DEFAULT 'Asia/Jakarta',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `divisions`
--

INSERT INTO `divisions` (`id`, `name`, `timezone`, `created_at`, `updated_at`) VALUES
(1, 'Kalimantan Tengah', 'Asia/Jakarta', '2024-12-17 04:19:52', '2025-01-05 09:18:12'),
(2, 'Kalimantan Timur', 'Asia/Makassar', '2024-12-17 04:19:52', '2025-01-06 07:39:10'),
(3, 'Jakarta', 'Asia/Jakarta', '2024-12-17 04:19:52', '2025-01-05 09:18:29');

-- --------------------------------------------------------

--
-- Table structure for table `educations`
--

CREATE TABLE `educations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `educations`
--

INSERT INTO `educations` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'SD', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(2, 'SMP', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(3, 'SMA', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(4, 'SMK', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(5, 'D1', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(6, 'D2', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(7, 'D3', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(8, 'D4', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(9, 'S1', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(10, 'S2', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(11, 'S3', '2024-12-17 04:19:52', '2024-12-17 04:19:52');

-- --------------------------------------------------------

--
-- Table structure for table `face_attendances`
--

CREATE TABLE `face_attendances` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `longitude` varchar(255) DEFAULT NULL,
  `photo` text DEFAULT NULL,
  `time_in` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `holidays`
--

CREATE TABLE `holidays` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `holidays`
--

INSERT INTO `holidays` (`id`, `date`, `name`, `created_at`, `updated_at`) VALUES
(27, '2025-01-01', 'Tahun Baru 2025 Masehi', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(28, '2025-01-27', 'Isra\' Mi\'raj Nabi Muhammad SAW', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(29, '2025-01-28', 'Cuti Bersama Tahun Baru Imlek 2576 Kongzili', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(30, '2025-01-29', 'Tahun Baru Imlek 2576 Kongzili', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(31, '2025-03-28', 'Cuti Bersama Hari Raya Nyepi Tahun Baru Saka 1947', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(32, '2025-03-29', 'Hari Raya Nyepi Tahun Baru Saka 1947', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(33, '2025-03-31', 'Hari Raya Idul Fitri 1446H', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(34, '2025-04-01', 'Hari Raya Idul Fitri 1446H', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(35, '2025-04-02', 'Cuti Bersama Hari Raya Idul Fitri 1446H', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(36, '2025-04-03', 'Cuti Bersama Hari Raya Idul Fitri 1446H', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(37, '2025-04-04', 'Cuti Bersama Hari Raya Idul Fitri 1446H', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(38, '2025-04-07', 'Cuti Bersama Hari Raya Idul Fitri 1446H', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(39, '2025-04-18', 'Wafat Yesus Kristus', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(40, '2025-04-20', 'Kebangkitan Yesus Kristus', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(41, '2025-05-01', 'Hari Buruh Internasional', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(42, '2025-05-12', 'Hari Raya Waisak 2569 BE', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(43, '2025-05-13', 'Cuti Bersama Hari Raya Waisak 2569 BE', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(44, '2025-05-29', 'Kenaikan Yesus Kristus', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(45, '2025-05-30', 'Cuti Bersama Kenaikan Yesus Kristus', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(46, '2025-06-01', 'Hari Lahir Pancasila', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(47, '2025-06-06', 'Hari Raya Idul Adha 1446H', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(48, '2025-06-09', 'Cuti Bersama Hari Raya Idul Adha 1446H', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(49, '2025-06-27', 'Tahun Baru Islam 1 Muharram 1447H', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(50, '2025-08-17', 'Hari Kemerdekaan Republik Indonesia ke 80', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(51, '2025-09-05', 'Maulid Nabi Muhammad SAW', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(52, '2025-12-25', 'Hari Raya Natal', '2025-01-30 08:09:45', '2025-01-30 08:09:45'),
(53, '2025-12-26', 'Cuti Bersama Hari Raya Natal', '2025-01-30 08:09:45', '2025-01-30 08:09:45');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_titles`
--

CREATE TABLE `job_titles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job_titles`
--

INSERT INTO `job_titles` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Manager', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(2, 'Staff', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(3, 'Accounting', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(4, 'HRD', '2024-12-17 04:19:52', '2024-12-17 04:19:52'),
(5, 'IT', '2024-12-17 04:19:52', '2024-12-17 04:19:52');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_divisions_table', 1),
(2, '0001_01_01_000000_create_educations_table', 1),
(3, '0001_01_01_000000_create_job_titles_table', 1),
(4, '0001_01_01_000000_create_users_table', 1),
(5, '0001_01_01_000001_add_two_factor_columns_to_users_table', 1),
(6, '0001_01_01_000001_create_cache_table', 1),
(7, '0001_01_01_000002_create_jobs_table', 1),
(8, '2024_06_08_023152_create_personal_access_tokens_table', 1),
(9, '2024_06_09_113236_create_barcodes_table', 1),
(10, '2024_06_16_092112_create_shifts_table', 1),
(11, '2024_06_17_113814_create_attendances_table', 1),
(12, '2024_12_18_073212_create_attendances_table', 2),
(13, '2024_12_20_195713_add_is_blocked_to_users_table', 3),
(14, '2024_12_21_094306_add_unblocked_at_to_users_table', 4),
(15, '2024_12_23_092903_add_approval_status_to_attendances_table', 5),
(16, '2025_01_01_210454_add_soft_deletes_to_attendances_table', 6),
(17, '2025_01_05_160943_add_timezone_to_divisions_table', 7),
(18, '2025_01_30_075515_create_holidays_table', 8);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` char(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` char(26) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('08zU3fzpwAuHaEPYj8lqBmsYMYb8Oqm2kIZq5v7N', NULL, '35.165.215.140', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) HeadlessChrome/130.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiN1VUWEE5ckNoVUJWbDZGdjFyaUIyVWdZMU5Fc05xSmNYd2R0U0lIOSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNDoiaHR0cHM6Ly9hYnNlbnNpLXBzcC5zaXRlIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYWJzZW5zaS1wc3Auc2l0ZS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738202814),
('2N5vK0iTzVkWvYG8GTESkcbVN0bLBzdDEaQeEZ7F', NULL, '2a12:5940:5433::2', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.0 Mobile/15E148 Safari/604.1', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWWF4YmVaRUdPUnNtNndMUVhnWVA1T2h3YXVlVlViSTUyUXFFdnRZZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYWJzZW5zaS1wc3Auc2l0ZS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738219804),
('B4qOcyXTppyZKjCaI2UyC5nNzwWjsvVhg4OzEezL', NULL, '35.165.215.140', 'Go-http-client/2.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZTRFbXZyTVVydndSeUNZOUIyM3ZHa2Fwamtta0FPZmNLZEpVWDduTiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyODoiaHR0cHM6Ly93d3cuYWJzZW5zaS1wc3Auc2l0ZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI4OiJodHRwczovL3d3dy5hYnNlbnNpLXBzcC5zaXRlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1738202813),
('bKH1xuvOG1Bnb1HMCAE3810M65M5C1sDi8EveFil', '01jf9dg0h5136g9t1gtjw00d26', '180.248.195.145', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiZzlKVjM5Zm9yb01aNTFjaXczeGJkOUI2RzhNekxFSWliazhTRXdnQSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MDoiaHR0cHM6Ly9hYnNlbnNpLXBzcC5zaXRlL2FkbWluL2Rhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtzOjI2OiIwMWpmOWRnMGg1MTM2Zzl0MWd0ancwMGQyNiI7czoyMToicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjtzOjYwOiIkMnkkMTIkeFFsMjRYa3E4VW5uNndjdHo4SEVLLlhISENJWE83RmdGSVk3Z2dzdUhobVVvRlc3Q3RXQ1MiO3M6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQwOiJodHRwczovL2Fic2Vuc2ktcHNwLnNpdGUvYWRtaW4vZW1wbG95ZWVzIjt9fQ==', 1738207935),
('DMQe3ksJ94f4ZWgr9mRPROamwgSloyMxNlqaAoEw', NULL, '35.165.215.140', 'Go-http-client/2.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiRzRDWkdvRjZxQmN0bnNrcmM4SUFTZXZ0WGlBdWs3QUl3ZHpNSG9iQyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNDoiaHR0cHM6Ly9hYnNlbnNpLXBzcC5zaXRlIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYWJzZW5zaS1wc3Auc2l0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738202813),
('fjxcuAQCekUZ50q06NEeZjHTlLPZU7KkmBRfnbb7', NULL, '2a02:4780:6:c0de::10', 'Go-http-client/2.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidlNjT3NTN3hZV25uOEExWndtRkNiUlNpcnZpZ0hqM1hMQ1o3WDYxeCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNToiaHR0cHM6Ly9hYnNlbnNpLXBzcC5zaXRlLiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738224587),
('ixPvdf2d2FSXfohErsqD5KC2F8NcNyPIjmt4YYpx', NULL, '5.133.192.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZUZDRURkYkdqYkVLTndGY0c0Wk9GZkd3ZXNEak9CQk1ISHFqSkJsTyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNDoiaHR0cHM6Ly9hYnNlbnNpLXBzcC5zaXRlIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYWJzZW5zaS1wc3Auc2l0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738240884),
('jEiqWs0me6XpzppMxndbM2db5BPckvl0AYqcA1p8', '01jf9dg0h5136g9t1gtjw00d26', '180.248.195.145', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiZ3JwTlBUUW5peXJQa0J2aEMxTGtSb3htUHU2MDR1UDdqRDVVVEJORSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MDoiaHR0cHM6Ly9hYnNlbnNpLXBzcC5zaXRlL2FkbWluL2Rhc2hib2FyZCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtzOjI2OiIwMWpmOWRnMGg1MTM2Zzl0MWd0ancwMGQyNiI7czoyMToicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjtzOjYwOiIkMnkkMTIkeFFsMjRYa3E4VW5uNndjdHo4SEVLLlhISENJWE83RmdGSVk3Z2dzdUhobVVvRlc3Q3RXQ1MiO3M6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQwOiJodHRwczovL2Fic2Vuc2ktcHNwLnNpdGUvYWRtaW4vZW1wbG95ZWVzIjt9fQ==', 1738281767),
('jLg8g4vIAxDi3BCp8XlAZxWMry6Y7vmMulD7FHTT', NULL, '2607:5300:60:6515::', 'EasyCron/1.0 (https://www.easycron.com/)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWlRzWUhpbjd5OTZEcDM1OVVST3NZc05jMThJWjRmSFRQakE1RjNrUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDA6Imh0dHBzOi8vYWJzZW5zaS1wc3Auc2l0ZS9ydW4tbWFyay1hYnNlbnQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1738256343),
('npE8Kc4pqCj7LCBS9sIkcftPOXxT9eAYKFXDgtTG', NULL, '138.246.253.7', 'quic-go-HTTP/3', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWVVUc3ZYSmwxZ0QzRFA3N1NyTmRBV2xYZk1QaFFkZTYxOWZQZXJTciI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNDoiaHR0cHM6Ly9hYnNlbnNpLXBzcC5zaXRlIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1738240702),
('qGoH7WNbhGDgAbC4kaVzmr3AULpGDD7nrO315ycd', NULL, '2a02:4780:6:c0de::10', 'Go-http-client/2.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoidUhXYzVaZW5xWUtqaXRxbVYxMkViSlVGczFMcENoNE5ZWTVMOVlyZCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1738224588),
('QkxVgUVDL4QlkhlBbq3t8KxGbk1W4XIbJmTyXKVU', NULL, '38.57.148.206', '\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36\"', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiZHpWTThtT1l3dDBSS2pNNUhCWlN0elVqdkVoTzNjdk1wQ3lJNFFPYiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyODoiaHR0cHM6Ly93d3cuYWJzZW5zaS1wc3Auc2l0ZSI7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM0OiJodHRwczovL3d3dy5hYnNlbnNpLXBzcC5zaXRlL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1738256304),
('QSotp0xsSYHXS1YzQbvzwYfpMnaamQzfkfKoV6bs', NULL, '64.23.169.228', 'Mozilla/5.0 (compatible)', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU2wyWUplNURRQlZIS3U5V3JiU1FLeU9qTkpIU3BPZVhaY2ZaZWZQRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYWJzZW5zaS1wc3Auc2l0ZS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738218486),
('Sl4WPjfcCCDUcwM7jwzTynYNKcCLbz470sg65l0A', NULL, '45.90.63.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.61 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidlI0SmNjN1BhUTF0UmkwZFlSaEt2WmVSaTF6cjczUEVYS21OeWxjcSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNDoiaHR0cHM6Ly9hYnNlbnNpLXBzcC5zaXRlIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYWJzZW5zaS1wc3Auc2l0ZS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738202053),
('uHnk2etlDPE5uv0oddaW22Qrq86pjrVptbwwrCqR', NULL, '34.209.111.88', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWXJId3g5TmdqV0RzR1dHcVlibXNUSGhQM041TEZZeTJrSUNNQVhseCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNDoiaHR0cHM6Ly9hYnNlbnNpLXBzcC5zaXRlIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYWJzZW5zaS1wc3Auc2l0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738243843),
('yvDQD5rLrrNuerhq79affYX1TABfJfmYxRHRee0Z', NULL, '34.219.48.234', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiOVlyZ0dmSGE5SWE5RHBGOXljNjdUOHdtaEZ1MlRYZEJxdTVpTTY0UCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNDoiaHR0cHM6Ly9hYnNlbnNpLXBzcC5zaXRlIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYWJzZW5zaS1wc3Auc2l0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738243843),
('z0bPKvjnk3de0d4GDStFd1tVmI4ESRLa21sFIRFh', NULL, '2a12:5940:5433::2', 'Mozilla/5.0 (iPhone; CPU iPhone OS 11_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.0 Mobile/15E148 Safari/604.1', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoid0kyTHI0QjdzQ1llOHFXc0tsWEprY0lQTmZJOW5TSEo3U25rMXhPTiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNDoiaHR0cHM6Ly9hYnNlbnNpLXBzcC5zaXRlIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYWJzZW5zaS1wc3Auc2l0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738219804),
('Z2ylstnH5zkFJhOgv87yX7skK28cZrKsSg4XWSjc', NULL, '34.219.48.234', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNVhlSE9WUWEwZ3VCUW02Y3JVbEJRY1NOWUE4dld6bXBLZ2JjdG9JTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYWJzZW5zaS1wc3Auc2l0ZS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738243844),
('zBZAbFl21UKGwAAijnzNYBnll31kWumNXaDHv0jb', NULL, '64.23.169.228', 'Mozilla/5.0 (compatible)', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNjQxNVExYjR5SWx6QUJIY2NST1NCWmdFOFRMd25LVll6aEc0WHhEMSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNDoiaHR0cHM6Ly9hYnNlbnNpLXBzcC5zaXRlIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjQ6Imh0dHBzOi8vYWJzZW5zaS1wc3Auc2l0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738218482),
('zUkuGeyem95Fkmownk1Dy8o1hbhgP6NnNItMvBfT', NULL, '5.133.192.135', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/105.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiakt4R1pXWUN0SGtoODJ0TmtLV3lORjQxT1RqcGNZWm1GcE44NTVzZyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHBzOi8vYWJzZW5zaS1wc3Auc2l0ZS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1738240885);

-- --------------------------------------------------------

--
-- Table structure for table `shifts`
--

CREATE TABLE `shifts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `division_id` bigint(20) UNSIGNED NOT NULL,
  `work_days` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`work_days`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shifts`
--

INSERT INTO `shifts` (`id`, `name`, `start_time`, `end_time`, `created_at`, `updated_at`, `division_id`, `work_days`) VALUES
(3, 'Kalimantan Tengah', '07:00:00', '15:00:00', '2025-01-05 09:35:32', '2025-01-09 07:29:06', 1, '[\"Senin\",\"Selasa\",\"Rabu\",\"Kamis\",\"Jumat\"]'),
(4, 'Kalimantan Timur', '07:00:00', '15:00:00', '2025-01-05 09:36:17', '2025-01-09 07:31:14', 2, '[\"Senin\",\"Selasa\",\"Rabu\",\"Kamis\",\"Jumat\",\"Sabtu\"]'),
(5, 'Jakarta', '08:30:00', '17:00:00', '2025-01-05 09:36:47', '2025-01-09 07:34:22', 3, '[\"Senin\",\"Selasa\",\"Rabu\",\"Kamis\",\"Jumat\"]'),
(6, 'Simling POLDA CFD', '06:30:00', '08:00:00', '2025-01-13 14:23:05', '2025-01-13 14:23:05', 1, '[\"Minggu\"]');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` char(26) NOT NULL,
  `nip` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `is_blocked` tinyint(1) NOT NULL DEFAULT 0,
  `unblocked_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `birth_date` date DEFAULT NULL,
  `birth_place` varchar(255) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `education_id` bigint(20) UNSIGNED DEFAULT NULL,
  `division_id` bigint(20) UNSIGNED DEFAULT NULL,
  `job_title_id` bigint(20) UNSIGNED DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `raw_password` varchar(255) DEFAULT NULL,
  `group` enum('user','admin','superadmin') NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `profile_photo_path` varchar(2048) DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nip`, `name`, `email`, `is_blocked`, `unblocked_at`, `phone`, `gender`, `birth_date`, `birth_place`, `address`, `city`, `education_id`, `division_id`, `job_title_id`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `raw_password`, `group`, `email_verified_at`, `profile_photo_path`, `remember_token`, `created_at`, `updated_at`) VALUES
('01jf9dg0h5136g9t1gtjw00d26', '0000000000000000', 'Super Admin', 'superadmin@example.com', 0, NULL, '00000000000', 'male', NULL, NULL, '', '', NULL, NULL, NULL, '$2y$12$xQl24Xkq8Unn6wctz8HEK.XHHCIXO7FgFIY7ggsuHhmUoFW7CtWCS', NULL, NULL, NULL, 'superadmin', 'superadmin', '2024-12-17 04:19:51', NULL, NULL, '2024-12-17 04:19:51', '2024-12-17 04:19:51'),
('01jf9drn1vvv57nrwmraqbshc2', '1234567', 'Dian Putra Anugrahnu', 'dianpea00@gmail.com', 1, '2025-01-15 10:04:28', '081374863257', 'male', '2024-12-17', 'Buntok', 'Jl. Garuda', 'Palangka Raya', 9, 1, 5, '$2y$12$9B2BkNn6ZI7.VOgE40UIwu/yIEgDt5MYf8.Mepm6M8MKJAxtMhdbG', 'eyJpdiI6Ik1qbDIxQUx5TmU5VWx2ZnBwaE5ZMkE9PSIsInZhbHVlIjoiOFNaeWUwa3hrd0RYcGZnRHMrY2hGdzhtVm0yWEMrakhVb3NIeXptNlZ5RT0iLCJtYWMiOiI5Nzg2Y2MwYjBjMGNlZGY2ODRjZWEwYzAzMjZjYzY3Y2ZiNDllZjMwM2EwYzdmYzcxMzhiMmMyZmI5MmU1MDhhIiwidGFnIjoiIn0=', 'eyJpdiI6IlhhRHpJbi92ZUNQUHRKMVNhTkxTaHc9PSIsInZhbHVlIjoiT0JjelZkcGVKYTBINHlkdHNySjNqNjZ4MmV2aHA1MmFIMFkxR0pxc2NDZDRpR1crdFFQenBUQ1Vsa3hvNHB1cndVS1kramlSb2tRcFloZ1JTMWJXS3QrTm1PRjBzYytCS3g5c08rb2NVUFRVUjk0RUFUcHBFZHg1cmtFQmQ3THJsMzhzQm9nbVo3ZlJHRmZ2MmNJUGlBbUhNSktzMURsellkZHlUWCt1Y0RDa214UnFwM2ZGdHF2TWFpRWVpWEVuRFBnRWtXd1IveURDbmMvNE5DNnBodzRYaC85T01lQTIrSVR1Z01kN2FkWHI2S0FpZHpIb2hTU0syUXh1UzNUNjgzT0kzSUxBVmdVeW9zbkVjUUZxS3c9PSIsIm1hYyI6ImEzNWRlN2MxNjAyMTJmYzQyY2Q2Yzk1ZWQ5OGVlNDk2YmNjNmVkNDUyMjFjNjYwYzE2YTI2NWQwNmM1MjgzZmMiLCJ0YWciOiIifQ==', '2025-01-02 00:12:51', 'Crono123', 'user', NULL, NULL, NULL, '2024-12-17 04:24:35', '2025-01-22 23:59:03'),
('01jgnef77aytmaj08sq2z9m2hf', '202403043', 'Anithae Krisdayantie', 'anithaekdjohan@gmail.com', 1, NULL, '08976777894', 'female', '1996-09-14', 'Palangka Raya', 'Jl. Bukit Raya X', 'Palangka Raya', 3, 1, 1, '$2y$12$Wh6RxZstAjs97y9ecMfiyONnFAZvlTKCG22z7qZ9RDAyb/y5qBDei', 'eyJpdiI6ImFoZEQ4OWh4eEVPaTF3eE83RFVXZ0E9PSIsInZhbHVlIjoiYUZqd2I2TnQybHd2RGFrRmxnMFF3VEdwZmpmKzZONHhzTzY2Q05pc1NSQT0iLCJtYWMiOiI4MTlmZGMzNGY3M2UwM2M3ZTRiZjcyOThkZjM3Yzg2NzMzYjI4NDU0OWFjMzc2NWI4ZTVkOGFiMjZmMzM2ODE0IiwidGFnIjoiIn0=', 'eyJpdiI6Ijk0NmJxMmNTamxUZDh1R2lMckdtZ1E9PSIsInZhbHVlIjoiYWZycG5iYzM1LzNKQ2FXVWNwM1NQaC9VdE5ieHlCSVFvcWNvbVNRS241dW0vY0kzOHJaUnNnK09rMGhXaU5yd0F6dExFb3VoQk9LbDVFOEdRWDlMTHE2a1FZSVRONDRnNVRNVU10cFZKOExFTkgrU2hFV0NibEZLcFhSM01iQms3YnZOTVhhUXNtZUY5Mk5qc2xURU5NTkpPTWNaMEFhUDlSOVVoWTRjNDlKTHpIWDQ2TXYyYXRLWGx3dGZSczJMUHNjYWVTSHEyaFJvaHRwNTdBWjIvZkdlNWN3NzhYK3gxZVNHU2dlS0JyNCtUR2pDOWtseDNTVitqbVZGbmhZendKYTVmWjJXa1FteDFYNE1KZGE3dEE9PSIsIm1hYyI6ImQ5MDU4Zjg1Yzk0OTk4MDlmZGUzNTBjMWVjNTI2MjQyMzVmMDAwZTRhMGI1NmUzNDhiMjljOGM2ODc2YjZmMTciLCJ0YWciOiIifQ==', '2025-01-03 14:04:29', 'tes12345', 'user', NULL, NULL, NULL, '2025-01-03 13:43:29', '2025-01-17 07:27:19'),
('01jgng7hvw40kpt6fgvqn2w604', '202409075', 'Andri Santoso', 'andri.santoso19@gmail.com', 1, NULL, '085246991141', 'male', '1984-08-29', 'Blitar', 'Jl Teuku Umar Gg.blora', 'Samarinda', 9, 2, 5, '$2y$12$DABOeHs5QaEp.nf339uH6efqFoPbOJDZd9KHkcNvHlQbg4bMXEPs2', NULL, NULL, NULL, 'tes12345', 'user', NULL, NULL, NULL, '2025-01-03 14:14:15', '2025-01-15 10:27:03'),
('01jgngax934sy0bqggkbgp6j68', '202306005', 'Panca Rini Andari', 'ayin907@gmail.com', 1, NULL, '082154207048', 'female', '1991-03-08', 'Loa Kulu', ' jalan m said gg polewali 3b2 no 2b2 rt 30 Lok bahu samarinda', 'Samarinda', 7, 2, 1, '$2y$12$4.8y6gnHTqw8JXia2WmadOfde6sJqeX07C1WDKH3.5qzZ6U5ydV0i', 'eyJpdiI6ImlZNEo1MHlkVjQ1ajVOc1NFZy9SbGc9PSIsInZhbHVlIjoiNWplMXYvTzBVdGpXVFhKQ2h0Z0U2aUMyQWVXblBEaVpEMVMzNUttdDJGaz0iLCJtYWMiOiI1ODNiMTczYzliNjRiYzE5MmE3NDljMDliZjRiYzY5Njg0YmNkOGZmNjMxNWQxYWJiYjI2ZGM3Y2M4NTY2Y2YzIiwidGFnIjoiIn0=', 'eyJpdiI6IlhtMThPMXdoQThMVnE5aHdEdzE1N1E9PSIsInZhbHVlIjoiL3B0K3k0WkdmOWM4YjJVN21FbjVnWmZsSkFrRkgxYkxHTmRCQ3RBMUYvUFdXYlFCUkpIM09kNnRZYUhrUzl2R00wSjZLcmg4NmFGZ1l0YmUydnVJaFpXY3NvTkVFVDI3ZVlOOFhsM0J1N3lEQjZNdndZMjdPaS9HdzdhTlBVZ2JzY0VzQzJBTGI5TzBEM0NnU2RkOGtDekxvL25XMVBuVDhwL0UwVk9YZFc3SEh1WjZjUVc1ZGQxcVVEclhMaDVGdnNmSXFhTjM1NjBTOFp2TXRiOEdUS3FuMGNISWlRZmZBTGliNFJoWU8wUFVTMmk2YU93YitjbUV5M3RnVTltRVJYSDJ2WUtxZWtjTTFxdnpZM1hTYmc9PSIsIm1hYyI6ImZkZjVjYmJjYzhlMDQ1YTE4NmNiMzEwMTVmYjcxZjllOTJiOTA2YzQwNWI3ODNlM2Q4NmFlMWUyNTQ2ZGNjZjYiLCJ0YWciOiIifQ==', '2025-01-03 14:23:47', 'tes12345', 'user', NULL, NULL, NULL, '2025-01-03 14:16:05', '2025-01-28 23:59:03'),
('01jgnmc8svsvhjth2efcq786tw', '202308024', 'Joy', 'moloruth8@gmail.com', 1, NULL, '082123177690', 'female', '2004-09-23', 'Jakarta', 'cipondoh, tangerang', 'Jakarta', 4, 3, 2, '$2y$12$7HixyOnOj5MNYRX03pOO4e08RlF2zIh93///jIxgf1rz.BXRN.I.O', 'eyJpdiI6Img3ajJENlpJdmp5VDJtNkFCZVQ4WGc9PSIsInZhbHVlIjoiSVNyNG84NXdnSVdVOUNWSkxPTEpEWk1uTlZzaDdhUklPUW8rTG9aY29uaz0iLCJtYWMiOiIxMGM1M2MyY2QyNWFmNjMzMGIwYjczZjg1ZjA4Mjg5ZjVhNjM5NTUzNDFhY2JmMzY2N2Q3YWJjZTMyZWZiN2EzIiwidGFnIjoiIn0=', 'eyJpdiI6IjNQWXgxWVE3a3F1SWI4K1RyNHRXRHc9PSIsInZhbHVlIjoiYUNwVk1MVnpoVXpENlZSTVI1TlhZUGpCWjJRZDRhS3Q3NTZ2NGxVUnAwdndWUDBTT3c4NzJmU0M5cmw0Nzd2Si81aHNNbi9lUEJIbHFCY3NoK1VzOUlLTWdYUGMvb0VIUmN3NnE5S0tjMTBEemFLUCtzM2NzcVBiY2V5OUxJOXdCVEdQSVo0ZU5JbjUyOXFjUStieEllQUhLZGwvc2V6MzljNkw0V3JkSXBqUHBid2FiVkczb24rMmw0dTdXcTJVNFRKWjM4NU1pVDA1UzJuUW9SeGsyeWcwR00vblEvbXdpNjQ3OGFJT1Rmb2xYNmpmWFJNYjFOcWhhYXR0TDk3SVM3TlVwL3dHaGtLQTAwbzEvd1J3U0E9PSIsIm1hYyI6IjY5ODE5MWQ2OGEzMTczODEyZjcxOTNlOTBmZDhhODBhY2FmM2JlZDQyNWQwMzIzNzBjOWE2ZmM4M2ViNTdlODgiLCJ0YWciOiIifQ==', '2025-01-03 15:28:21', 'tes12345', 'user', NULL, NULL, NULL, '2025-01-03 15:26:44', '2025-01-17 07:27:19'),
('01jh0gvfxagd790515w43dysjj', NULL, 'Supervisor Kalimantan Tengah', 'supervisorkalteng@gmail.com', 0, NULL, '081212344321', 'female', NULL, NULL, 'Jl. Tjilik Riwut', 'Palangka Raya', NULL, 1, NULL, '$2y$12$UcPCDKqmQO7/nwsOoLLsVun0rH4hHPbHyxQ59SR1VKqLad9ji4LVa', NULL, NULL, NULL, NULL, 'admin', NULL, NULL, NULL, '2025-01-07 20:56:47', '2025-01-07 20:56:47'),
('01jh0gx9q2m91jbvq9w6vwkwdx', NULL, 'Supervisor Kalimantan Timur', 'supervisorkaltim@gmail.com', 0, NULL, '081243211234', 'female', NULL, NULL, 'Jl. Samarinda', 'Samarinda', NULL, 2, NULL, '$2y$12$3l1cVp5ikWljn958qMFG3eKlWOHcMSFFeg16pBEwDpd2kcnNsBFsq', NULL, NULL, NULL, NULL, 'admin', NULL, NULL, NULL, '2025-01-07 20:57:46', '2025-01-07 20:57:46'),
('01jhsh1b7qxgnbgbjp2mtejvmr', '66667777', 'Testing', 'testing@gmail.com', 0, '2025-01-28 19:56:45', '087766554433', 'female', '2025-01-17', 'Jakarta', 'Jl. Pelita IV, Gg.Gloria, No.44, Kalimantan Tengah, Barito Selatan', 'Buntok', 1, 1, 2, '$2y$12$u9ax7nvtxyQnmsmgadebZeuWsV2v/nHcJpqUjcUXn/CqYi8oB0CyW', NULL, NULL, NULL, 'testing', 'user', NULL, NULL, NULL, '2025-01-17 14:01:00', '2025-01-28 19:56:45');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendances`
--
ALTER TABLE `attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attendances_user_id_foreign` (`user_id`),
  ADD KEY `attendances_barcode_id_foreign` (`barcode_id`),
  ADD KEY `attendances_shift_id_foreign` (`shift_id`);

--
-- Indexes for table `barcodes`
--
ALTER TABLE `barcodes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `barcodes_value_unique` (`value`),
  ADD KEY `fk_barcode_division` (`division_id`),
  ADD KEY `fk_shift_id` (`shift_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `divisions`
--
ALTER TABLE `divisions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `divisions_name_unique` (`name`);

--
-- Indexes for table `educations`
--
ALTER TABLE `educations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `educations_name_unique` (`name`);

--
-- Indexes for table `face_attendances`
--
ALTER TABLE `face_attendances`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `holidays`
--
ALTER TABLE `holidays`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `holidays_date_unique` (`date`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_titles`
--
ALTER TABLE `job_titles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `job_titles_name_unique` (`name`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_education_id_foreign` (`education_id`),
  ADD KEY `users_division_id_foreign` (`division_id`),
  ADD KEY `users_job_title_id_foreign` (`job_title_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendances`
--
ALTER TABLE `attendances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=216;

--
-- AUTO_INCREMENT for table `barcodes`
--
ALTER TABLE `barcodes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `divisions`
--
ALTER TABLE `divisions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `educations`
--
ALTER TABLE `educations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `face_attendances`
--
ALTER TABLE `face_attendances`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `holidays`
--
ALTER TABLE `holidays`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job_titles`
--
ALTER TABLE `job_titles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shifts`
--
ALTER TABLE `shifts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendances`
--
ALTER TABLE `attendances`
  ADD CONSTRAINT `attendances_barcode_id_foreign` FOREIGN KEY (`barcode_id`) REFERENCES `barcodes` (`id`),
  ADD CONSTRAINT `attendances_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`),
  ADD CONSTRAINT `attendances_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `barcodes`
--
ALTER TABLE `barcodes`
  ADD CONSTRAINT `fk_barcode_division` FOREIGN KEY (`division_id`) REFERENCES `divisions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_division_id_foreign` FOREIGN KEY (`division_id`) REFERENCES `divisions` (`id`),
  ADD CONSTRAINT `users_education_id_foreign` FOREIGN KEY (`education_id`) REFERENCES `educations` (`id`),
  ADD CONSTRAINT `users_job_title_id_foreign` FOREIGN KEY (`job_title_id`) REFERENCES `job_titles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
