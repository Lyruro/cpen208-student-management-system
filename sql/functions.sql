CREATE OR REPLACE FUNCTION university.calculate_outstanding_fees()
RETURNS JSON AS
$$
DECLARE
    result JSON;
BEGIN

SELECT json_agg(
    json_build_object(
        'student_id', s.student_id,
        'student_name', CONCAT(s.first_name, ' ', s.last_name),
        'total_fees', s.total_fees,
        'amount_paid', COALESCE(fp.total_paid,0),
        'outstanding_fees',
            s.total_fees - COALESCE(fp.total_paid,0)
    )
)
INTO result

FROM university.student s

LEFT JOIN
(
    SELECT
        student_id,
        SUM(amount_paid) AS total_paid
    FROM university.fee_payment
    GROUP BY student_id
) fp

ON s.student_id = fp.student_id;

RETURN result;

END;
$$
LANGUAGE plpgsql;