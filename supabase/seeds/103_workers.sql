-- Worker 5: Joe Liemandt
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'a31f1c4d-1c33-4030-96bd-3bf7243714c6',
    'joe.liemandt@gauntlet.com',
    now() - interval '8 days',
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
    'a31f1c4d-1c33-4030-96bd-3bf7243714c6',
    'joe.liemandt@gauntlet.com',
    'Joe',
    'Liemandt',
    'Security Specialist',
    'America/Denver',
    ARRAY['Security', 'Pen Testing', 'Firewall'],
    ARRAY['en'],
    '{"tickets_resolved": 2, "avg_response_time": 35}'::jsonb,
    '{}',
    '[]'::jsonb,
    now() - interval '8 days'
);

-- Worker 6: Rebecca Metters
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'a178c08e-83f1-4cff-9955-dd64dc058354',
    'rebecca.metters@gauntlet.com',
    now() - interval '11 days',
    now() - interval '5 days',
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
    'a178c08e-83f1-4cff-9955-dd64dc058354',
    'rebecca.metters@gauntlet.com',
    'Rebecca',
    'Metters',
    'Customer Success Manager',
    'Europe/London',
    ARRAY['Customer Success', 'Account Management', 'Product Training'],
    ARRAY['en', 'de'],
    '{"tickets_resolved": 10, "avg_response_time": 30}'::jsonb,
    '{}',
    '[]'::jsonb,
    now() - interval '11 days'
);
