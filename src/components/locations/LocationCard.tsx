
import React from 'react';
import { Link } from 'react-router-dom';
import { MapPin } from 'lucide-react';
import { Location } from '@/data';

interface LocationCardProps {
  location: Location;
}

const LocationCard: React.FC<LocationCardProps> = ({ location }) => {
  return (
    <div className="bg-white rounded-lg shadow-md overflow-hidden transition-all hover:shadow-lg">
      <div className="relative h-48 overflow-hidden">
        <img 
          src={location.mainImage} 
          alt={location.name}
          className="w-full h-full object-cover transition-transform hover:scale-105"
        />
        <div className="absolute inset-0 bg-gradient-to-b from-transparent to-black/60"></div>
        <div className="absolute bottom-0 left-0 p-4 text-white">
          <h3 className="text-xl font-bold">{location.name}</h3>
        </div>
      </div>
      
      <div className="p-4">
        <div className="flex items-start gap-2 text-recife-medium mb-3">
          <MapPin size={18} className="shrink-0 mt-1" />
          <p className="text-sm line-clamp-1">{location.address}</p>
        </div>
        
        <p className="text-sm text-recife-dark line-clamp-3 mb-4">
          {location.description}
        </p>
        
        <Link 
          to={`/location/${location.id}`}
          className="block text-center bg-recife-primary hover:bg-recife-primary-hover text-white py-2 rounded-md font-medium transition-colors"
        >
          Explorar Local
        </Link>
      </div>
    </div>
  );
};

export default LocationCard;
