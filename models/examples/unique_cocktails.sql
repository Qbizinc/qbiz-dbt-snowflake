SELECT * FROM sandbox_data_pipeline.public.cocktails
QUALIFY ROW_NUMBER() OVER (PARTITION BY drink_id ORDER BY run_hr DESC) = 1