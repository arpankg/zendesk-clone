-- Worker 3: Zac Smith
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'f61f3731-b70e-4fa8-af5c-17be2fba141c',
    'zac.smith@gauntlet.com',
    now() - interval '10 days',
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
    'f61f3731-b70e-4fa8-af5c-17be2fba141c',
    'zac.smith@gauntlet.com',
    'Zac',
    'Smith',
    'Support Team Lead',
    'America/Chicago',
    ARRAY['Team Management', 'Escalations', 'Quality Assurance'],
    ARRAY['en', 'es'],
    '{"tickets_resolved": 25, "avg_response_time": 15}'::jsonb,
    '{}',
    '[]'::jsonb,
    now() - interval '10 days'
);

-- Worker 4: Neeraj Gupta
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'bf446b73-41c7-48aa-a8c0-2ee4d3f7605b',
    'neeraj.gupta@gauntlet.com',
    now() - interval '12 days',
    now() - interval '3 days',
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
    'bf446b73-41c7-48aa-a8c0-2ee4d3f7605b',
    'neeraj.gupta@gauntlet.com',
    'Neeraj',
    'Gupta',
    'Billing Specialist',
    'Asia/Kolkata',
    ARRAY['Billing', 'Payment Processing', 'Refunds'],
    ARRAY['en', 'hi'],
    '{"tickets_resolved": 8, "avg_response_time": 27}'::jsonb,
    '{}',
    '[]'::jsonb,
    now() - interval '12 days'
);
