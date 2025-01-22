-- Sample customer data for the support system
-- Each customer has different communication preferences and history

-- Existing customers (DO NOT REMOVE):

-- Customer 1: Basic web user
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58',
    'test@gmail.com',
    now(),
    now(),
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
    '5084b3db-d1cf-4cf9-8ab1-0b1a6f145e58',
    'Test',
    'User',
    ARRAY['web'],
    'en',
    'test@gmail.com',
    '{"feedback": []}'::jsonb,
    now(),
    now()
);

-- Customer 2: Multi-channel user with feedback history
INSERT INTO auth.users (
    id,
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'f23c5c88-2322-4c2d-9f59-43e79a9b5c44',
    'sarah.miller@example.com',
    now() - interval '30 days',
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
    'f23c5c88-2322-4c2d-9f59-43e79a9b5c44',
    'Sarah',
    'Miller',
    ARRAY['web', 'email', 'chat'],
    'en',
    'sarah.miller@example.com',
    '{
        "feedback": [
            {
                "rating": 5,
                "comment": "Great support team!",
                "submitted_at": "2024-12-20T14:30:00Z",
                "ticket_id": "d290f1ee-6c54-4b01-90e6-d701748f0851"
            },
            {
                "rating": 4,
                "comment": "Quick response, but needed follow-up",
                "submitted_at": "2024-12-15T09:15:00Z",
                "ticket_id": "04d0f1ee-6c54-4b01-90e6-d701748f0852"
            }
        ]
    }'::jsonb,
    now() - interval '30 days',
    now() - interval '30 days'
);

-- Customer 3: International user
INSERT INTO auth.users (
    id,
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '7d3e41c9-9a5d-4e4f-a71c-94b17e8f6e24',
    'carlos.garcia@example.com',
    now() - interval '60 days',
    now() - interval '5 days',
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
    '7d3e41c9-9a5d-4e4f-a71c-94b17e8f6e24',
    'Carlos',
    'Garcia',
    ARRAY['web', 'email'],
    'es',
    'carlos.garcia@example.com',
    '{
        "feedback": [
            {
                "rating": 3,
                "comment": "Servicio regular, problemas de idioma",
                "submitted_at": "2024-11-28T16:45:00Z",
                "ticket_id": "14d0f1ee-6c54-4b01-90e6-d701748f0853"
            }
        ]
    }'::jsonb,
    now() - interval '60 days',
    now() - interval '60 days'
);

-- Customer 4: New user
INSERT INTO auth.users (
    id,
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f',
    'john.doe@example.com',
    now() - interval '2 days',
    now() - interval '1 day',
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
    'a1b2c3d4-e5f6-4a5b-9c8d-1a2b3c4d5e6f',
    'John',
    'Doe',
    ARRAY['web'],
    'en',
    'john.doe@example.com',
    '{"feedback": []}'::jsonb,
    now() - interval '2 days',
    now() - interval '2 days'
);

-- Customer 5: Power user with multiple channels
INSERT INTO auth.users (
    id,
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9',
    'emma.wilson@example.com',
    now() - interval '90 days',
    now(),
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
    'b5e7d31c-8a2f-4b9c-9d6e-f4c3a2b1e0d9',
    'Emma',
    'Wilson',
    ARRAY['web', 'email', 'chat', 'phone'],
    'en',
    'emma.wilson@example.com',
    '{
        "feedback": [
            {
                "rating": 5,
                "comment": "Excellent support every time!",
                "submitted_at": "2024-12-28T11:20:00Z",
                "ticket_id": "24d0f1ee-6c54-4b01-90e6-d701748f0854"
            },
            {
                "rating": 5,
                "comment": "Very helpful team",
                "submitted_at": "2024-12-10T13:45:00Z",
                "ticket_id": "34d0f1ee-6c54-4b01-90e6-d701748f0855"
            },
            {
                "rating": 4,
                "comment": "Good service overall",
                "submitted_at": "2024-11-15T09:30:00Z",
                "ticket_id": "44d0f1ee-6c54-4b01-90e6-d701748f0856"
            }
        ]
    }'::jsonb,
    now() - interval '90 days',
    now() - interval '90 days'
);

-- NEW CUSTOMERS (10 additional) -----------------------------------------------

-- Customer 6
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '733d23f0-5057-4737-8a70-656deee126be',
    'alice.martin@example.com',
    now() - interval '10 days',
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
    '733d23f0-5057-4737-8a70-656deee126be',
    'Alice',
    'Martin',
    ARRAY['web', 'email'],
    'en',
    'alice.martin@example.com',
    '{
      "feedback": []
    }'::jsonb,
    now() - interval '10 days',
    now() - interval '10 days'
);

-- Customer 7
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    'b0a16a7f-b48b-4254-a7d7-fc5f79e3c263',
    'mehmet.ersoy@example.com',
    now() - interval '20 days',
    now() - interval '5 days',
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
    'b0a16a7f-b48b-4254-a7d7-fc5f79e3c263',
    'Mehmet',
    'Ersoy',
    ARRAY['chat', 'web', 'phone'],
    'tr',
    'mehmet.ersoy@example.com',
    '{
      "feedback": []
    }'::jsonb,
    now() - interval '20 days',
    now() - interval '20 days'
);

-- Customer 8
INSERT INTO auth.users (
    id, 
    email,
    created_at,
    last_sign_in_at,
    raw_app_meta_data,
    raw_user_meta_data,
    is_super_admin
) VALUES (
    '2f046dd1-cd22-4fca-a9d4-624b48b61b6d',
    'jun.kim@example.com',
    now() - interval '15 days',
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
    '2f046dd1-cd22-4fca-a9d4-624b48b61b6d',
    'Jun',
    'Kim',
    ARRAY['web', 'chat'],
    'ko',
    'jun.kim@example.com',
    '{
      "feedback": [
        {
          "rating": 4,
          "comment": "Good service, but language docs missing",
          "submitted_at": "2025-01-10T09:15:00Z",
          "ticket_id": "eb3f90ba-e2bb-4b68-9b79-d6cdf8abec2f"
        }
      ]
    }'::jsonb,
    now() - interval '15 days',
    now() - interval '15 days'
);

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

