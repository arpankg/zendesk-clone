-- Worker 1: Austen Allred
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8',
    'austen.allred@gauntlet.com',
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
    assigned_tickets,
    ticket_history,
    created_at
) VALUES (
    'b4e57ca5-ebe7-4d29-9e0a-66bb028df3d8',
    'austen.allred@gauntlet.com',
    'Austen',
    'Allred',
    'Senior Technical Support',
    'America/Los_Angeles',
    ARRAY['Technical Support', 'API Integration', 'Database Management'],
    ARRAY['en'],
    '{"tickets_resolved": 15, "avg_response_time": 10}'::jsonb,
    '{}',
    '[]'::jsonb,
    now() - interval '7 days'
);

-- Worker 2: Ash Tilawat
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'd89637a2-1f11-4027-86db-e7d47a579ae1',
    'ash.tilawat@gauntlet.com',
    now() - interval '5 days',
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
    assigned_tickets,
    ticket_history,
    created_at
) VALUES (
    'd89637a2-1f11-4027-86db-e7d47a579ae1',
    'ash.tilawat@gauntlet.com',
    'Ash',
    'Tilawat',
    'Product Support Specialist',
    'America/New_York',
    ARRAY['Product Features', 'User Training', 'Bug Reporting'],
    ARRAY['en', 'fr'],
    '{"tickets_resolved": 4, "avg_response_time": 20}'::jsonb,
    '{}',
    '[]'::jsonb,
    now() - interval '5 days'
);
