
-- Company budget categories (payroll, marketing, office, legal, software, travel, etc.)
CREATE TABLE public.company_budget_categories (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  team_id UUID NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  annual_budget NUMERIC NOT NULL DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

ALTER TABLE public.company_budget_categories ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Team members can view company budget categories"
  ON public.company_budget_categories FOR SELECT
  USING (is_team_member(team_id));

CREATE POLICY "Owners/managers can insert company budget categories"
  ON public.company_budget_categories FOR INSERT
  WITH CHECK (is_team_owner_or_manager(team_id));

CREATE POLICY "Owners/managers can update company budget categories"
  ON public.company_budget_categories FOR UPDATE
  USING (is_team_owner_or_manager(team_id));

CREATE POLICY "Owners/managers can delete company budget categories"
  ON public.company_budget_categories FOR DELETE
  USING (is_team_owner_or_manager(team_id));

-- Company-level expenses (manual entries for non-artist expenses)
CREATE TABLE public.company_expenses (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  team_id UUID NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
  category_id UUID REFERENCES public.company_budget_categories(id) ON DELETE SET NULL,
  description TEXT NOT NULL,
  amount NUMERIC NOT NULL DEFAULT 0,
  expense_date DATE NOT NULL DEFAULT CURRENT_DATE,
  is_recurring BOOLEAN NOT NULL DEFAULT false,
  recurrence_period TEXT, -- 'monthly', 'quarterly', 'annual'
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now()
);

ALTER TABLE public.company_expenses ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Team members can view company expenses"
  ON public.company_expenses FOR SELECT
  USING (is_team_member(team_id));

CREATE POLICY "Owners/managers can insert company expenses"
  ON public.company_expenses FOR INSERT
  WITH CHECK (is_team_owner_or_manager(team_id));

CREATE POLICY "Owners/managers can update company expenses"
  ON public.company_expenses FOR UPDATE
  USING (is_team_owner_or_manager(team_id));

CREATE POLICY "Owners/managers can delete company expenses"
  ON public.company_expenses FOR DELETE
  USING (is_team_owner_or_manager(team_id));

-- Staff employment info
CREATE TABLE public.staff_employment (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  team_id UUID NOT NULL REFERENCES public.teams(id) ON DELETE CASCADE,
  employment_type TEXT NOT NULL DEFAULT 'w2', -- 'w2' or '1099'
  job_title TEXT,
  annual_salary NUMERIC, -- for W-2
  monthly_retainer NUMERIC, -- for 1099
  payment_schedule TEXT DEFAULT 'bi-weekly', -- 'weekly', 'bi-weekly', 'semi-monthly', 'monthly'
  start_date DATE,
  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
  UNIQUE(user_id, team_id)
);

ALTER TABLE public.staff_employment ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Team members can view staff employment"
  ON public.staff_employment FOR SELECT
  USING (is_team_member(team_id));

CREATE POLICY "Owners/managers can insert staff employment"
  ON public.staff_employment FOR INSERT
  WITH CHECK (is_team_owner_or_manager(team_id));

CREATE POLICY "Owners/managers can update staff employment"
  ON public.staff_employment FOR UPDATE
  USING (is_team_owner_or_manager(team_id));

CREATE POLICY "Owners/managers can delete staff employment"
  ON public.staff_employment FOR DELETE
  USING (is_team_owner_or_manager(team_id));

-- Add annual_budget column to teams for overall company budget
ALTER TABLE public.teams ADD COLUMN IF NOT EXISTS annual_budget NUMERIC DEFAULT 0;
