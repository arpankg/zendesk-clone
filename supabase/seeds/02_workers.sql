-- Sample worker data for the support system
-- Each worker has different roles, skills, and languages

-- Existing workers (DO NOT REMOVE):

-- Worker 1: Senior Technical Support
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8',
    'sarah.tech@company.com',
    now(),
    now(),
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    '98f2dfb4-c6a1-4d17-9e3b-b531e5d7c6f8',
    'sarah.tech@company.com',
    'Sarah',
    'Johnson',
    'Senior Technical Support',
    'America/New_York',
    ARRAY['Technical Support', 'API Integration', 'Database Management'],
    ARRAY['en', 'es'],
    '{"tickets_resolved": 0, "avg_response_time": 0}'::jsonb,
    now()
);

-- Worker 2: Customer Success Manager
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '2c9a7d31-4e8f-42b5-9d63-8f7a1b5e4c2d',
    'mike.success@company.com',
    now(),
    now(),
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    '2c9a7d31-4e8f-42b5-9d63-8f7a1b5e4c2d',
    'mike.success@company.com',
    'Mike',
    'Williams',
    'Customer Success Manager',
    'America/Los_Angeles',
    ARRAY['Customer Success', 'Account Management', 'Product Training'],
    ARRAY['en', 'fr'],
    '{"tickets_resolved": 0, "avg_response_time": 0}'::jsonb,
    now()
);

-- Worker 3: Billing Support
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f',
    'lisa.billing@company.com',
    now(),
    now(),
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    '4f6e8d2b-1a3c-5b7e-9f4d-2c8a6b4e1d3f',
    'lisa.billing@company.com',
    'Lisa',
    'Brown',
    'Billing Support',
    'Europe/London',
    ARRAY['Billing', 'Payment Processing', 'Refunds'],
    ARRAY['en', 'de'],
    '{"tickets_resolved": 0, "avg_response_time": 0}'::jsonb,
    now()
);

-- Worker 4: Product Support Specialist
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '7a1b5e4c-2d3f-6789-9012-1a2b3c4d5e6f',
    'alex.product@company.com',
    now(),
    now(),
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    '7a1b5e4c-2d3f-6789-9012-1a2b3c4d5e6f',
    'alex.product@company.com',
    'Alex',
    'Chen',
    'Product Support Specialist',
    'Asia/Singapore',
    ARRAY['Product Features', 'User Training', 'Bug Reporting'],
    ARRAY['en', 'zh', 'yue'],
    '{"tickets_resolved": 0, "avg_response_time": 0}'::jsonb,
    now()
);

-- Worker 5: Support Team Lead
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab',
    'james.lead@company.com',
    now(),
    now(),
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    '9d8c7b6a-5e4f-3d2e-1f0a-9876543210ab',
    'james.lead@company.com',
    'James',
    'Martinez',
    'Support Team Lead',
    'America/Chicago',
    ARRAY['Team Management', 'Escalations', 'Process Improvement', 'Quality Assurance'],
    ARRAY['en', 'es', 'pt'],
    '{"tickets_resolved": 0, "avg_response_time": 0}'::jsonb,
    now()
);

-- NEW WORKERS (10 additional) -----------------------------------------------

-- Worker 6
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'e031a9c5-a539-491f-9fe2-543dba660762',
    'tyrone.support@company.com',
    now() - interval '5 days',
    now() - interval '1 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    'e031a9c5-a539-491f-9fe2-543dba660762',
    'tyrone.support@company.com',
    'Tyrone',
    'Jones',
    'Technical Support Rep',
    'America/Denver',
    ARRAY['API Integration', 'Troubleshooting'],
    ARRAY['en'],
    '{"tickets_resolved": 10, "avg_response_time": 12}'::jsonb,
    now()
);

-- Worker 7
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '6138599f-f760-4fac-9b8d-7b9ee6ed3b75',
    'david.security@company.com',
    now() - interval '14 days',
    now(),
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    '6138599f-f760-4fac-9b8d-7b9ee6ed3b75',
    'david.security@company.com',
    'David',
    'Hall',
    'Security Specialist',
    'America/Toronto',
    ARRAY['Security', 'Pen Testing', 'Firewall'],
    ARRAY['en'],
    '{"tickets_resolved": 3, "avg_response_time": 30}'::jsonb,
    now()
);

-- Worker 8
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'a729d2ef-55c5-42f7-a211-88bcd104ec37',
    'linda.training@company.com',
    now() - interval '20 days',
    now() - interval '1 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    'a729d2ef-55c5-42f7-a211-88bcd104ec37',
    'linda.training@company.com',
    'Linda',
    'Gonzalez',
    'Training Specialist',
    'America/Sao_Paulo',
    ARRAY['User Training', 'Onboarding'],
    ARRAY['en', 'pt'],
    '{"tickets_resolved": 8, "avg_response_time": 25}'::jsonb,
    now()
);

-- Worker 9
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'adbe0789-cd70-4055-a0d5-c4fb2829384f',
    'keiko.qa@company.com',
    now() - interval '30 days',
    now() - interval '2 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    'adbe0789-cd70-4055-a0d5-c4fb2829384f',
    'keiko.qa@company.com',
    'Keiko',
    'Sato',
    'Quality Assurance',
    'Asia/Tokyo',
    ARRAY['QA Testing', 'Bug Reporting'],
    ARRAY['ja', 'en'],
    '{"tickets_resolved": 2, "avg_response_time": 40}'::jsonb,
    now()
);

-- Worker 10
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '6e9f0df7-30c3-4b41-a444-6fddb9a68183',
    'sabrina.europe@company.com',
    now() - interval '2 days',
    now() - interval '1 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    '6e9f0df7-30c3-4b41-a444-6fddb9a68183',
    'sabrina.europe@company.com',
    'Sabrina',
    'Hoffmann',
    'European Support Lead',
    'Europe/Berlin',
    ARRAY['Escalations', 'EU Regulations'],
    ARRAY['en', 'de'],
    '{"tickets_resolved": 12, "avg_response_time": 18}'::jsonb,
    now()
);

-- Worker 11
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'd24408aa-a333-4633-8a49-47d1ac3e24e2',
    'roberto.billing@company.com',
    now() - interval '5 days',
    now(),
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    'd24408aa-a333-4633-8a49-47d1ac3e24e2',
    'roberto.billing@company.com',
    'Roberto',
    'Silva',
    'Billing Specialist',
    'America/Santiago',
    ARRAY['Billing', 'Payment Disputes'],
    ARRAY['pt', 'es'],
    '{"tickets_resolved": 6, "avg_response_time": 20}'::jsonb,
    now()
);

-- Worker 12
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'fc8cfe87-38ba-4c7b-937a-6c6f57f18c36',
    'nina.research@company.com',
    now() - interval '12 days',
    now() - interval '2 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    'fc8cfe87-38ba-4c7b-937a-6c6f57f18c36',
    'nina.research@company.com',
    'Nina',
    'Verma',
    'Product Researcher',
    'Asia/Kolkata',
    ARRAY['User Feedback Analysis', 'Surveys'],
    ARRAY['en', 'hi'],
    '{"tickets_resolved": 1, "avg_response_time": 15}'::jsonb,
    now()
);

-- Worker 13
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'd9d6cb12-ff54-4813-bd88-330a9c8d8ddf',
    'olga.operations@company.com',
    now() - interval '7 days',
    now() - interval '1 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    'd9d6cb12-ff54-4813-bd88-330a9c8d8ddf',
    'olga.operations@company.com',
    'Olga',
    'Petrova',
    'Operations Manager',
    'Europe/Moscow',
    ARRAY['Process Improvement'],
    ARRAY['ru', 'en'],
    '{"tickets_resolved": 4, "avg_response_time": 35}'::jsonb,
    now()
);

-- Worker 14
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '3fa45c76-c802-42f5-bd4c-9090877d5295',
    'amir.analytics@company.com',
    now() - interval '3 days',
    now(),
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.workers (
    id,
    email,
    first_name,
    last_name,
    role,
    timezone,
    skills,
    languages,
    metrics,
    created_at
) VALUES (
    '3fa45c76-c802-42f5-bd4c-9090877d5295',
    'amir.analytics@company.com',
    'Amir',
    'Azimi',
    'Analytics Engineer',
    'Asia/Tehran',
    ARRAY['Data Analysis', 'Reporting'],
    ARRAY['en', 'fa'],
    '{"tickets_resolved": 0, "avg_response_time": 0}'::jsonb,
    now()
);
