-- Update Course-Specialization Mappings to allow >20 credits per specialization
-- Currently most specializations max out at 12-16 credits

SET FOREIGN_KEY_CHECKS = 0;

-- ============================================================
-- 1. MACHINE LEARNING (Spec ID 4) - Current Max: 16
-- Add: NLP(14), Vision(15), Big Data(10)
-- ============================================================
INSERT IGNORE INTO course_specialization (course_id, specialization_id, credits_toward_specialization) VALUES
(14, 4, 4), -- AI302 NLP
(15, 4, 4), -- AI303 Computer Vision
(10, 4, 3); -- DS301 Big Data

-- ============================================================
-- 2. FULL STACK DEVELOPMENT (Spec ID 15) - Current Max: 16
-- Add: Database(4), HTML/CSS(20), Cloud Fund(29)
-- ============================================================
INSERT IGNORE INTO course_specialization (course_id, specialization_id, credits_toward_specialization) VALUES
(4, 15, 4),  -- CS202 DBMS
(20, 15, 3), -- WEB101 HTML/CSS
(29, 15, 3); -- CLD201 Cloud Fundamentals

-- ============================================================
-- 3. DEEP LEARNING (Spec ID 7) - Current Max: 12
-- Add: ML(8), AI(12), Vision(15)
-- ============================================================
INSERT IGNORE INTO course_specialization (course_id, specialization_id, credits_toward_specialization) VALUES
(8, 7, 4),  -- DS201 ML
(12, 7, 4), -- AI201 AI
(15, 7, 4); -- AI303 Vision

-- ============================================================
-- 4. NETWORK SECURITY (Spec ID 10) - Current Max: 11
-- Add: OS(6), Cloud Arch(30)
-- ============================================================
INSERT IGNORE INTO course_specialization (course_id, specialization_id, credits_toward_specialization) VALUES
(6, 10, 4),  -- CS302 OS
(30, 10, 4); -- CLD301 Cloud Arch

-- ============================================================
-- 5. CLOUD ARCHITECTURE (Spec ID 18) - Current Max: 11
-- Add: Dist Systems/Big Data(10), Network Sec(16)
-- ============================================================
INSERT IGNORE INTO course_specialization (course_id, specialization_id, credits_toward_specialization) VALUES
(10, 18, 4), -- DS301 Big Data
(16, 18, 4); -- SEC201 Network Sec

-- ============================================================
-- 6. BUSINESS INTELLIGENCE (Spec ID 20) - Current Max: 11
-- Add: Big Data(10), Stats(9)
-- ============================================================
INSERT IGNORE INTO course_specialization (course_id, specialization_id, credits_toward_specialization) VALUES
(10, 20, 4), -- DS301 Big Data
(9, 20, 4);  -- DS202 Stats

SET FOREIGN_KEY_CHECKS = 1;
