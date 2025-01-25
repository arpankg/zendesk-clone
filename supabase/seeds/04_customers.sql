-- Customer 9
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'afb2c4e2-0c9a-4b99-8fa7-ab84cbe77cb3',
    'helga.schmidt@example.com',
    now() - interval '40 days',
    now() - interval '2 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.customers (
    id,
    first_name,
    last_name,
    communication_channels,
    preferred_language,
    email,
    feedback_history,
    created_at,
    updated_at
) VALUES (
    'afb2c4e2-0c9a-4b99-8fa7-ab84cbe77cb3',
    'Helga',
    'Schmidt',
    ARRAY['email', 'phone'],
    'de',
    'helga.schmidt@example.com',
    '{
      "feedback": [
        {
          "rating": 5,
          "comment": "Sehr schnelle Hilfe, danke!",
          "submitted_at": "2025-01-08T14:12:00Z",
          "ticket_id": "d7cfd54c-b15b-407c-af70-9771289ed6c2"
        }
      ]
    }'::jsonb,
    now() - interval '40 days',
    now() - interval '40 days'
);

-- Customer 10
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '42b47744-9457-45ae-8db9-ece7beb8bb24',
    'sylvie.durand@example.com',
    now() - interval '35 days',
    now() - interval '1 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.customers (
    id,
    first_name,
    last_name,
    communication_channels,
    preferred_language,
    email,
    feedback_history,
    created_at,
    updated_at
) VALUES (
    '42b47744-9457-45ae-8db9-ece7beb8bb24',
    'Sylvie',
    'Durand',
    ARRAY['web'],
    'fr',
    'sylvie.durand@example.com',
    '{
      "feedback": []
    }'::jsonb,
    now() - interval '35 days',
    now() - interval '35 days'
);

-- Customer 11
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'f2d6e459-99af-4d4b-b761-cf39df48a8d0',
    'li.wei@example.com',
    now() - interval '50 days',
    now() - interval '10 days',
    '{"provider":"email","providers":["email"]}',
    '{}',
    false
);

INSERT INTO public.customers (
    id,
    first_name,
    last_name,
    communication_channels,
    preferred_language,
    email,
    feedback_history,
    created_at,
    updated_at
) VALUES (
    'f2d6e459-99af-4d4b-b761-cf39df48a8d0',
    'Li',
    'Wei',
    ARRAY['chat', 'web'],
    'zh',
    'li.wei@example.com',
    '{
      "feedback": []
    }'::jsonb,
    now() - interval '50 days',
    now() - interval '50 days'
);
