type DashboardCardProps = {
  title: string;
  value: number;
};

export default function DashboardCard({
  title,
  value,
}: DashboardCardProps) {
  return (
    <div className="bg-white rounded-xl shadow-md p-6 hover:shadow-lg transition">
      <h2 className="text-gray-500 text-sm uppercase tracking-wide">
        {title}
      </h2>

      <p className="text-4xl font-bold text-blue-700 mt-4">
        {value}
      </p>
    </div>
  );
}