-- Customer 12
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '6f46bb43-1913-4bd0-8489-3f8c8575f633',
    'aarav.patel@example.com',
    now() - interval '25 days',
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
    '6f46bb43-1913-4bd0-8489-3f8c8575f633',
    'Aarav',
    'Patel',
    ARRAY['email', 'phone'],
    'en',
    'aarav.patel@example.com',
    '{
      "feedback": [
        {
          "rating": 2,
          "comment": "Response took too long",
          "submitted_at": "2025-01-05T11:00:00Z",
          "ticket_id": "139e729e-5a32-4894-9c1f-afce9d148dc3"
        }
      ]
    }'::jsonb,
    now() - interval '25 days',
    now() - interval '25 days'
);

-- Customer 13
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'c1b417d9-4c1f-4d56-a13e-bffbc0595f74',
    'marcus.larsson@example.com',
    now() - interval '45 days',
    now() - interval '3 days',
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
    'c1b417d9-4c1f-4d56-a13e-bffbc0595f74',
    'Marcus',
    'Larsson',
    ARRAY['web', 'chat'],
    'sv',
    'marcus.larsson@example.com',
    '{
      "feedback": []
    }'::jsonb,
    now() - interval '45 days',
    now() - interval '45 days'
);

-- Customer 14
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '7affd409-0087-4a44-9922-bf28027feea7',
    'lucia.rodriguez@example.com',
    now() - interval '60 days',
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
    '7affd409-0087-4a44-9922-bf28027feea7',
    'Lucia',
    'Rodriguez',
    ARRAY['web', 'chat', 'phone'],
    'es',
    'lucia.rodriguez@example.com',
    '{
      "feedback": [
        {
          "rating": 5,
          "comment": "Excelente soporte, gracias!",
          "submitted_at": "2025-01-04T08:40:00Z",
          "ticket_id": "c06d489f-f18a-45ad-8393-ff7bf9ee3b60"
        }
      ]
    }'::jsonb,
    now() - interval '60 days',
    now() - interval '60 days'
);

-- Customer 15
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'c9dd1b9c-cd53-4f02-a88c-7252c6451f36',
    'fatima.ali@example.com',
    now() - interval '14 days',
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
    'c9dd1b9c-cd53-4f02-a88c-7252c6451f36',
    'Fatima',
    'Ali',
    ARRAY['web', 'chat'],
    'ar',
    'fatima.ali@example.com',
    '{
      "feedback": []
    }'::jsonb,
    now() - interval '14 days',
    now() - interval '14 days'
);
