-- Sample worker data for the support system
-- Each worker has different roles, skills, and languages

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
    ARRAY['English', 'Spanish'],
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
    ARRAY['English', 'French'],
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
    ARRAY['English', 'German'],
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
    ARRAY['English', 'Mandarin', 'Cantonese'],
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
    ARRAY['English', 'Spanish', 'Portuguese'],
    '{"tickets_resolved": 0, "avg_response_time": 0}'::jsonb,
    now()
);
