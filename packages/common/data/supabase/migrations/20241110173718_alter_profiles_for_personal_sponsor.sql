-- RLSチェック用の関数を作成
-- 個人スポンサーの場合はtrueを返す
-- それ以外の場合 もしくは ユーザ・チケットが存在しない場合はfalseを返す
CREATE FUNCTION public.is_profile_published_as_individual_sponsor (search_user_id UUID) returns boolean security definer
SET
  search_path = public language plpgsql AS $$
BEGIN
  RETURN (
    SELECT 1
    FROM public.profiles as p
    WHERE p.id = search_user_id AND is_published = TRUE AND (
      SELECT 1
      FROM public.tickets as t
      WHERE t.user_id = search_user_id AND t.type = 'individual_sponsor'::ticket_type
    )::boolean
  );
END;
$$;

-- 新しいポリシーを作成
CREATE POLICY "Everyone can read individual_sponsor in profiles" ON public.profiles FOR
SELECT
  USING (public.is_profile_published_as_individual_sponsor (id));

CREATE POLICY "Everyone can read individual_sponsor in profile_social_networking_services" ON public.profile_social_networking_services FOR
SELECT
  USING (public.is_profile_published_as_individual_sponsor (id));
